defmodule CarouselBuilder.Carousels do
  @moduledoc """
  The Carousels context.
  """

  import Ecto.Query, warn: false

  alias CarouselBuilder.{
    Carousels.Carousel,
    Repo
  }

  @doc """
  Returns the list of carousels.

  ## Examples

      iex> list_carousels()
      [%Carousel{}, ...]

  """
  def list_carousels do
    Repo.all(Carousel)
  end

  @doc """
  Gets a single carousel.

  Raises `Ecto.NoResultsError` if the Carousel does not exist.

  ## Examples

      iex> get_carousel!(123)
      %Carousel{}

      iex> get_carousel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_carousel!(id), do: Repo.get!(Carousel, id)

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
