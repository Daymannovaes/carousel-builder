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
      carousel: carousel.carousel,
      status: carousel.status
    }
  end
end
