defmodule CarouselBuilderWeb.CarouselController do
  use CarouselBuilderWeb, :controller

  import CarouselBuilderWeb.Helpers

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
    case id_is_valid?(id) do
      true ->
        case Carousels.get_carousel(id) do
          nil -> {:error, :not_found}
          carousel -> render(conn, :show, carousel: carousel)
        end

      _ ->
        {:error, :bad_request}
    end
  end

  def update(conn, %{"id" => id, "carousel" => carousel_params}) do
    case id_is_valid?(id) do
      true ->
        carousel = Carousels.get_carousel(id)

        with {:ok, %Carousel{} = carousel} <- Carousels.update_carousel(carousel, carousel_params) do
          render(conn, :show, carousel: carousel)
        end

      _ ->
        {:error, :bad_request}
    end
  end

  def delete(conn, %{"id" => id}) do
    case id_is_valid?(id) do
      true ->
        carousel = Carousels.get_carousel(id)

        with {:ok, %Carousel{}} <- Carousels.delete_carousel(carousel) do
          send_resp(conn, :no_content, "")
        end

      _ ->
        {:error, :bad_request}
    end
  end
end
