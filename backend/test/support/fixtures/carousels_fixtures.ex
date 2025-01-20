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
            background_color: "#005BBB",
            font_color: "#FFD500",
            position: 1,
            quill_delta_content: "quill_content_1"
          },
          %{
            background_color: "#009246",
            font_color: "#CE2B37",
            position: 2,
            quill_delta_content: "quill_content_2"
          }
        ]
      })
      |> CarouselBuilder.Carousels.create_carousel()

    carousel
  end
end
