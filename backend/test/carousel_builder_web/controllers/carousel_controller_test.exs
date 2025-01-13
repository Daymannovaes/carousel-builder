defmodule CarouselBuilderWeb.CarouselControllerTest do
  use CarouselBuilderWeb.ConnCase

  import CarouselBuilder.CarouselsFixtures

  alias CarouselBuilder.Carousels.Carousel

  @create_attrs %{
    name: "some name",
    is_active: true,
    slides: [
      %{
        background_color: "#FFFFFF",
        font_color: "#000000",
        position: 1,
        quill_delta_content: "quill_content_1"
      }
    ]
  }

  @update_attrs %{
    name: "some updated name",
    is_active: false,
    slides: [
      %{
        background_color: "#000000",
        font_color: "#FFFFFF",
        position: 1,
        quill_delta_content: "quill_content_2"
      }
    ]
  }

  @invalid_attrs %{name: nil, is_active: nil}

  @valid_settings %{
    background_color: "#FF00FF",
    font_color: "#00FF00"
  }

  @invalid_settings %{
    background_color: nil,
    font_color: nil
  }

  @invalid_settings_fields %{
    invalid_field: ["invalid value"]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all carousels", %{conn: conn} do
      conn = get(conn, ~p"/api/carousels")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "show carousel" do
    setup [:create_carousel]

    test "renders carousel when id is valid", %{conn: conn, carousel: %Carousel{id: id}} do
      conn = get(conn, ~p"/api/carousels/#{id}")
      assert json_response(conn, 200)["data"]["id"] == id
    end

    test "returns error when carousel is not found", %{conn: conn} do
      non_existing_id = 42

      conn = get(conn, ~p"/api/carousels/#{non_existing_id}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = get(conn, ~p"/api/carousels/abc")
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
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
               "name" => "some name",
               "slides" => [
                 %{
                   "background_color" => "#FFFFFF",
                   "font_color" => "#000000",
                   "position" => 1,
                   "quill_delta_content" => "quill_content_1"
                 }
               ]
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
               "name" => "some updated name",
               "slides" => [
                 %{
                   "background_color" => "#000000",
                   "font_color" => "#FFFFFF",
                   "position" => 1,
                   "quill_delta_content" => "quill_content_2"
                 }
               ]
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, carousel: carousel} do
      conn = put(conn, ~p"/api/carousels/#{carousel}", carousel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "returns error when carousel is not found", %{conn: conn} do
      non_existing_id = 42

      conn = put(conn, ~p"/api/carousels/#{non_existing_id}", carousel: @update_attrs)
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = put(conn, ~p"/api/carousels/abc", carousel: @update_attrs)
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  describe "update settings in carousel" do
    setup [:create_carousel]

    test "renders updated carousel when settings are valid", %{
      conn: conn,
      carousel: %Carousel{id: id} = carousel
    } do
      conn = put(conn, ~p"/api/carousels/#{id}/settings", settings: @valid_settings)
      carousel_response = json_response(conn, 200)
      slides = carousel_response["data"]["slides"]

      assert carousel_response["data"]["id"] == carousel.id
      assert length(slides) == 2

      for slide <- slides do
        assert slide["background_color"] == @valid_settings.background_color
        assert slide["font_color"] == @valid_settings.font_color
      end
    end

    test "returns error when settings has invalid values", %{
      conn: conn,
      carousel: %Carousel{id: id}
    } do
      conn = put(conn, ~p"/api/carousels/#{id}/settings", settings: @invalid_settings)

      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end

    test "returns error when settings has invalid fields", %{
      conn: conn,
      carousel: %Carousel{id: id}
    } do
      conn = put(conn, ~p"/api/carousels/#{id}/settings", settings: @invalid_settings_fields)

      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end

    test "returns error when carousel is not found", %{conn: conn} do
      non_existing_id = 42

      conn = put(conn, ~p"/api/carousels/#{non_existing_id}/settings", settings: @valid_settings)

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = put(conn, ~p"/api/carousels/abc/settings", settings: @valid_settings)

      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  describe "delete carousel" do
    setup [:create_carousel]

    test "deletes chosen carousel", %{conn: conn, carousel: carousel} do
      conn = delete(conn, ~p"/api/carousels/#{carousel}")
      assert json_response(conn, 200)["message"] == "Carousel deleted successfully"

      conn = get(conn, ~p"/api/carousels/#{carousel}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when carousel is not found", %{conn: conn} do
      non_existing_id = 42

      conn = delete(conn, ~p"/api/carousels/#{non_existing_id}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = delete(conn, ~p"/api/carousels/abc")
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  defp create_carousel(_) do
    carousel = carousel_fixture()
    %{carousel: carousel}
  end
end
