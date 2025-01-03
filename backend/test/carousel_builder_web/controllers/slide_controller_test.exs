defmodule CarouselBuilderWeb.SlideControllerTest do
  use CarouselBuilderWeb.ConnCase

  import CarouselBuilder.SlidesFixtures

  alias CarouselBuilder.Slides.Slide

  @create_attrs %{
    position: 42,
    background_color: "some background_color",
    font_color: "some font_color",
    quill_delta_content: "some quill_delta_content"
  }
  @update_attrs %{
    position: 43,
    background_color: "some updated background_color",
    font_color: "some updated font_color",
    quill_delta_content: "some updated quill_delta_content"
  }
  @invalid_attrs %{
    position: nil,
    background_color: nil,
    font_color: nil,
    quill_delta_content: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all slides", %{conn: conn} do
      conn = get(conn, ~p"/api/slides")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create slide" do
    test "renders slide when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/slides", slide: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/slides/#{id}")

      assert %{
               "id" => ^id,
               "background_color" => "some background_color",
               "font_color" => "some font_color",
               "position" => 42,
               "quill_delta_content" => "some quill_delta_content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/slides", slide: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update slide" do
    setup [:create_slide]

    test "renders slide when data is valid", %{conn: conn, slide: %Slide{id: id} = slide} do
      conn = put(conn, ~p"/api/slides/#{slide}", slide: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/slides/#{id}")

      assert %{
               "id" => ^id,
               "background_color" => "some updated background_color",
               "font_color" => "some updated font_color",
               "position" => 43,
               "quill_delta_content" => "some updated quill_delta_content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, slide: slide} do
      conn = put(conn, ~p"/api/slides/#{slide}", slide: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete slide" do
    setup [:create_slide]

    test "deletes chosen slide", %{conn: conn, slide: slide} do
      conn = delete(conn, ~p"/api/slides/#{slide}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/slides/#{slide}")
      end
    end
  end

  defp create_slide(_) do
    slide = slide_fixture()
    %{slide: slide}
  end
end
