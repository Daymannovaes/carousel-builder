defmodule CarouselBuilder.Slides do
  @moduledoc """
  The Slides context.
  """

  import Ecto.Query, warn: false

  alias CarouselBuilder.{
    Repo,
    Slides.Slide
  }

  @doc """
  Returns the list of slides.

  ## Examples

      iex> list_slides()
      [%Slide{}, ...]

  """
  def list_slides do
    Slide
    |> Repo.all()
    |> Repo.preload(:carousel)
  end

  @doc """
  Gets a single slide.

  Returns `nil` if the Slide does not exist.

  ## Examples

      iex> get_slide(123)
      %Slide{}

      iex> get_slide(456)
      nil

  """
  def get_slide(id) do
    case Repo.get(Slide, id) do
      nil -> nil
      slide -> Repo.preload(slide, :carousel)
    end
  end

  @doc """
  Creates a slide.

  ## Examples

      iex> create_slide(%{field: value})
      {:ok, %Slide{}}

      iex> create_slide(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slide(attrs \\ %{}) do
    %Slide{}
    |> Slide.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, slide} ->
        slide_with_carousel = Repo.preload(slide, :carousel)
        {:ok, slide_with_carousel}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a slide.

  ## Examples

      iex> update_slide(slide, %{field: new_value})
      {:ok, %Slide{}}

      iex> update_slide(slide, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slide(%Slide{} = slide, attrs) do
    slide
    |> Slide.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a slide.

  ## Examples

      iex> delete_slide(slide)
      {:ok, %Slide{}}

      iex> delete_slide(slide)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slide(%Slide{} = slide) do
    Repo.delete(slide)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slide changes.

  ## Examples

      iex> change_slide(slide)
      %Ecto.Changeset{data: %Slide{}}

  """
  def change_slide(%Slide{} = slide, attrs \\ %{}) do
    Slide.changeset(slide, attrs)
  end
end
