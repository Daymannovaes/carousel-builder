defmodule CarouselBuilderWeb.CarouselController do
  use CarouselBuilderWeb, :controller

  alias CarouselBuilder.{
    Carousels,
    Carousels.Carousel
  }

  action_fallback CarouselBuilderWeb.FallbackController

  def index(conn, _params) do
    carousels = Carousels.list_carousels()
    render(conn, :index, carousels: carousels)
  end

  def create(conn, %{"carousel" => carousel_params}) do
    with {:ok, %Carousel{} = carousel} <- Carousels.create_carousel(carousel_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/carousels/#{carousel}")
      |> render(:show, carousel: carousel)
    end
  end

  def show(conn, %{"id" => id}) do
    carousel = Carousels.get_carousel!(id)
    render(conn, :show, carousel: carousel)
  end

  def update(conn, %{"id" => id, "carousel" => carousel_params}) do
    carousel = Carousels.get_carousel!(id)

    with {:ok, %Carousel{} = carousel} <- Carousels.update_carousel(carousel, carousel_params) do
      render(conn, :show, carousel: carousel)
    end
  end

  def delete(conn, %{"id" => id}) do
    carousel = Carousels.get_carousel!(id)

    with {:ok, %Carousel{}} <- Carousels.delete_carousel(carousel) do
      send_resp(conn, :no_content, "")
    end
  end
end
