defmodule CarouselBuilder.SlidesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarouselBuilder.Slides` context.
  """

  import CarouselBuilder.CarouselsFixtures

  alias CarouselBuilder.{
    Repo,
    Slides
  }

  @doc """
  Generate a slide.
  """
  def slide_fixture(attrs \\ %{}) do
    carousel = carousel_fixture()

    {:ok, slide} =
      attrs
      |> Enum.into(%{
        background_color: "some background_color",
        font_color: "some font_color",
        position: 42,
        quill_delta_content: "some quill_delta_content",
        carousel_id: carousel.id
      })
      |> Slides.create_slide()

    Repo.preload(slide, :carousel)
  end
end
