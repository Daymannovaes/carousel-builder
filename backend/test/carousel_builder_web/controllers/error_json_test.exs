defmodule CarouselBuilderWeb.ErrorJSONTest do
  use CarouselBuilderWeb.ConnCase, async: true

  test "renders 400" do
    assert CarouselBuilderWeb.ErrorJSON.render("400.json", %{}) == %{
             errors: %{detail: "Bad Request"}
           }
  end

  test "renders 404" do
    assert CarouselBuilderWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert CarouselBuilderWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
