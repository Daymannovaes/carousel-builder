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
        carousel: %{},
        status: true
      })
      |> CarouselBuilder.Carousels.create_carousel()

    carousel
  end
end
