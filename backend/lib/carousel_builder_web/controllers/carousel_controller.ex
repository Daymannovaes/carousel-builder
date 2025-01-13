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
    case value_is_positive_integer?(id) do
      true ->
        case Carousels.get_carousel(id) do
          nil -> {:error, :not_found}
          carousel -> render(conn, :show, carousel: carousel)
        end

      _not_integer ->
        {:error, :bad_request}
    end
  end

  def update(conn, %{"id" => id, "carousel" => carousel_params}) do
    case value_is_positive_integer?(id) do
      true ->
        case Carousels.get_carousel(id) do
          nil ->
            {:error, :not_found}

          carousel ->
            with {:ok, %Carousel{} = carousel} <-
                   Carousels.update_carousel(carousel, carousel_params) do
              render(conn, :show, carousel: carousel)
            end
        end

      _not_integer ->
        {:error, :bad_request}
    end
  end

  def update_settings(conn, %{"id" => id, "settings" => settings_params}) do
    case value_is_positive_integer?(id) do
      true ->
        case Carousels.get_carousel(id) do
          nil ->
            {:error, :not_found}

          carousel ->
            updated_carousel = Carousels.update_all_slides_settings(carousel, settings_params)
            render(conn, :show, carousel: updated_carousel)
        end

      _ ->
        {:error, :bad_request}
    end
  end

  def delete(conn, %{"id" => id}) do
    case value_is_positive_integer?(id) do
      true ->
        case Carousels.get_carousel(id) do
          nil ->
            {:error, :not_found}

          carousel ->
            with {:ok, %Carousel{}} <- Carousels.delete_carousel(carousel) do
              conn
              |> put_status(:ok)
              |> json(%{message: "Carousel deleted successfully", id: id})
            end
        end

      _not_integer ->
        {:error, :bad_request}
    end
  end
end
