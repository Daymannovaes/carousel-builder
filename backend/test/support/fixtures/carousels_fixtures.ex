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
        name: "some name"
      })
      |> CarouselBuilder.Carousels.create_carousel()

    carousel
  end
end
