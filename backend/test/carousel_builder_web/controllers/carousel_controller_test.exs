defmodule CarouselBuilderWeb.CarouselControllerTest do
  use CarouselBuilderWeb.ConnCase

  import CarouselBuilder.CarouselsFixtures

  alias CarouselBuilder.Carousels.Carousel

  @create_attrs %{
    name: "some name",
    is_active: true
  }
  @update_attrs %{
    name: "some updated name",
    is_active: false
  }
  @invalid_attrs %{name: nil, is_active: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all carousels", %{conn: conn} do
      conn = get(conn, ~p"/api/carousels")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create carousel" do
    test "renders carousel when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/carousels", carousel: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/carousels/#{id}")

      assert %{
               "id" => ^id,
               "is_active" => true,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/carousels", carousel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update carousel" do
    setup [:create_carousel]

    test "renders carousel when data is valid", %{
      conn: conn,
      carousel: %Carousel{id: id} = carousel
    } do
      conn = put(conn, ~p"/api/carousels/#{carousel}", carousel: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/carousels/#{id}")

      assert %{
               "id" => ^id,
               "is_active" => false,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, carousel: carousel} do
      conn = put(conn, ~p"/api/carousels/#{carousel}", carousel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete carousel" do
    setup [:create_carousel]

    test "deletes chosen carousel", %{conn: conn, carousel: carousel} do
      conn = delete(conn, ~p"/api/carousels/#{carousel}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/carousels/#{carousel}")
      end
    end
  end

  defp create_carousel(_) do
    carousel = carousel_fixture()
    %{carousel: carousel}
  end
end
