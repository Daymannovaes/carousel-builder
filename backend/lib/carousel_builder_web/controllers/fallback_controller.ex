defmodule CarouselBuilderWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use CarouselBuilderWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: CarouselBuilderWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause handles 400 errors.
  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: CarouselBuilderWeb.ErrorJSON)
    |> render(:"400")
  end

  # This clause handles 404 errors.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: CarouselBuilderWeb.ErrorJSON)
    |> render(:"404")
  end
end
