defmodule CarouselBuilder.CarouselsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarouselBuilder.Carousels` context.
  """

  @doc """
  Generate a carousel.
  """
  def carousel_fixture(attrs \\ %{}) do
    {:ok, carousel} =
      attrs
      |> Enum.into(%{
        is_active: true,
        name: "some name",
        slides: [
          %{
            background_color: "#FFFFFF",
            font_color: "#000000",
            position: 1,
            quill_delta_content: "quill_content_1"
          },
          %{
            background_color: "#FF0000",
            font_color: "#00FF00",
            position: 2,
            quill_delta_content: "quill_content_2"
          }
        ]
      })
      |> CarouselBuilder.Carousels.create_carousel()

    carousel
  end
end
