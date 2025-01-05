defmodule CarouselBuilderWeb.SlideController do
  use CarouselBuilderWeb, :controller

  import CarouselBuilderWeb.Helpers

  alias CarouselBuilder.{
    Slides,
    Slides.Slide
  }

  action_fallback CarouselBuilderWeb.FallbackController

  def index(conn, _params) do
    slides = Slides.list_slides()
    render(conn, :index, slides: slides)
  end

  def create(conn, %{"slide" => slide_params}) do
    with {:ok, %Slide{} = slide} <- Slides.create_slide(slide_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/slides/#{slide}")
      |> render(:show, slide: slide)
    end
  end

  def show(conn, %{"id" => id}) do
    case id_is_valid?(id) do
      true ->
        case Slides.get_slide(id) do
          nil -> {:error, :not_found}
          slide -> render(conn, :show, slide: slide)
        end

      _ ->
        {:error, :bad_request}
    end
  end

  def update(conn, %{"id" => id, "slide" => slide_params}) do
    case id_is_valid?(id) do
      true ->
        slide = Slides.get_slide(id)

        with {:ok, %Slide{} = slide} <- Slides.update_slide(slide, slide_params) do
          render(conn, :show, slide: slide)
        end

      _ ->
        {:error, :bad_request}
    end
  end

  def delete(conn, %{"id" => id}) do
    case id_is_valid?(id) do
      true ->
        slide = Slides.get_slide(id)

        with {:ok, %Slide{}} <- Slides.delete_slide(slide) do
          send_resp(conn, :no_content, "")
        end

      _ ->
        {:error, :bad_request}
    end
  end
end
