defmodule CarouselBuilderWeb.SlideControllerTest do
  use CarouselBuilderWeb.ConnCase

  import CarouselBuilder.{
    CarouselsFixtures,
    SlidesFixtures
  }

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

  describe "show slide" do
    setup [:create_slide]

    test "renders slide when id is valid", %{conn: conn, slide: %Slide{id: id}} do
      conn = get(conn, ~p"/api/slides/#{id}")
      assert json_response(conn, 200)["data"]["id"] == id
    end

    test "returns error when slide is not found", %{conn: conn} do
      non_existing_id = 42

      conn = get(conn, ~p"/api/slides/#{non_existing_id}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = get(conn, ~p"/api/slides/abc")
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  describe "create slide" do
    test "renders slide when data is valid", %{conn: conn} do
      carousel = carousel_fixture()
      valid_attrs = Map.put(@create_attrs, :carousel_id, carousel.id)

      conn = post(conn, ~p"/api/slides", slide: valid_attrs)
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

    test "renders errors when data and carousel are invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/slides", slide: @invalid_attrs)
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end

    test "renders errors when data is invalid but carousel is valid", %{conn: conn} do
      carousel = carousel_fixture()
      invalid_attrs = Map.put(@invalid_attrs, :carousel_id, carousel.id)

      conn = post(conn, ~p"/api/slides", slide: invalid_attrs)

      assert json_response(conn, 422) == %{
               "errors" => %{
                 "background_color" => ["can't be blank"],
                 "font_color" => ["can't be blank"],
                 "position" => ["can't be blank"],
                 "quill_delta_content" => ["can't be blank"]
               }
             }
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

    test "returns error when slide is not found", %{conn: conn} do
      non_existing_id = 42

      conn = put(conn, ~p"/api/slides/#{non_existing_id}", slide: @update_attrs)
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = put(conn, ~p"/api/slides/abc", slide: @update_attrs)
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  describe "delete slide" do
    setup [:create_slide]

    test "deletes chosen slide", %{conn: conn, slide: slide} do
      conn = delete(conn, ~p"/api/slides/#{slide}")
      assert json_response(conn, 200)["message"] == "Slide deleted successfully"

      conn = get(conn, ~p"/api/slides/#{slide}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when slide is not found", %{conn: conn} do
      non_existing_id = 42

      conn = delete(conn, ~p"/api/slides/#{non_existing_id}")
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "returns error when passing invalid param", %{conn: conn} do
      conn = delete(conn, ~p"/api/slides/abc")
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end

  defp create_slide(_) do
    carousel = carousel_fixture()
    slide = slide_fixture(%{carousel_id: carousel.id})
    %{carousel: carousel, slide: slide}
  end
end
