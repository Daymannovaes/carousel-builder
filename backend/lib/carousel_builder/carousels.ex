defmodule CarouselBuilder.Carousels do
  @moduledoc """
  The Carousels context.
  """

  import Ecto.Query, warn: false

  alias CarouselBuilder.{
    Carousels.Carousel,
    Repo,
    Slides.Slide
  }

  @doc """
  Returns the list of carousels.

  ## Examples

      iex> list_carousels()
      [%Carousel{}, ...]

  """
  def list_carousels do
    Repo.all(
      from c in Carousel,
        where: c.is_active == true,
        preload: [:slides]
    )
  end

  @doc """
  Gets a single carousel.

  Returns `nil` if the Carousel does not exist.

  ## Examples

      iex> get_carousel(123)
      %Carousel{}

      iex> get_carousel(456)
      nil

  """
  def get_carousel(id) do
    case Repo.get(Carousel, id) do
      nil -> nil
      carousel -> Repo.preload(carousel, :slides)
    end
  end

  @doc """
  Creates a carousel.

  ## Examples

      iex> create_carousel(%{field: value})
      {:ok, %Carousel{}}

      iex> create_carousel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_carousel(attrs \\ %{}) do
    %Carousel{}
    |> Carousel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a carousel.

  ## Examples

      iex> update_carousel(carousel, %{field: new_value})
      {:ok, %Carousel{}}

      iex> update_carousel(carousel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_carousel(%Carousel{} = carousel, attrs) do
    carousel
    |> Carousel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates all slides settings from a carousel.

  ## Examples

      iex> update_all_slides_settings(carousel, %{field: new_value})
      %Carousel{}

      iex> update_all_slides_settings(carousel, %{field: bad_value})
      %Carousel{}

  """
  def update_all_slides_settings(%Carousel{} = carousel, %{
        "background_color" => background_color,
        "font_color" => font_color
      }) do
    Slide
    |> where([s], s.carousel_id == ^carousel.id)
    |> update(set: [background_color: ^background_color, font_color: ^font_color])
    |> Repo.update_all([])

    Carousel
    |> Repo.get(carousel.id)
    |> Repo.preload(:slides)
  end

  @doc """
  Deletes a carousel.

  ## Examples

      iex> delete_carousel(carousel)
      {:ok, %Carousel{}}

      iex> delete_carousel(carousel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_carousel(%Carousel{} = carousel) do
    Repo.delete(carousel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking carousel changes.

  ## Examples

      iex> change_carousel(carousel)
      %Ecto.Changeset{data: %Carousel{}}

  """
  def change_carousel(%Carousel{} = carousel, attrs \\ %{}) do
    Carousel.changeset(carousel, attrs)
  end
end
