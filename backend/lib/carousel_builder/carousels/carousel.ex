defmodule CarouselBuilder.Carousels.Carousel do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "carousels" do
    field :carousel, :map, default: %{}
    field :status, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(carousel, attrs) do
    carousel
    |> cast(attrs, [:carousel, :status])
    |> validate_required([:carousel, :status])
  end
end
