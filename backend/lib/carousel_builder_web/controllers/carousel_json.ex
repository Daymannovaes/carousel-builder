defmodule CarouselBuilderWeb.CarouselJSON do
  alias CarouselBuilder.Carousels.Carousel

  @doc """
  Renders a list of carousels.
  """
  def index(%{carousels: carousels}) do
    %{data: for(carousel <- carousels, do: data(carousel))}
  end

  @doc """
  Renders a single carousel.
  """
  def show(%{carousel: carousel}) do
    %{data: data(carousel)}
  end

  defp data(%Carousel{} = carousel) do
    %{
      id: carousel.id,
      name: carousel.name,
      is_active: carousel.is_active,
      slides: render_slides(carousel.slides)
    }
  end

  defp render_slides(slides) when is_list(slides) do
    Enum.map(slides, fn slide ->
      %{
        id: slide.id,
        background_color: slide.background_color,
        font_color: slide.font_color,
        position: slide.position,
        quill_delta_content: slide.quill_delta_content
      }
    end)
  end
  defp render_slides(_), do: []
end
