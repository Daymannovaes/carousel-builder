defmodule CarouselBuilder.SlidesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarouselBuilder.Slides` context.
  """

  @doc """
  Generate a slide.
  """
  def slide_fixture(attrs \\ %{}) do
    {:ok, slide} =
      attrs
      |> Enum.into(%{
        background_color: "some background_color",
        font_color: "some font_color",
        position: 42,
        quill_delta_content: "some quill_delta_content"
      })
      |> CarouselBuilder.Slides.create_slide()

    slide
  end
end
