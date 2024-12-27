defmodule CarouselBuilder.Carousels.Carousel do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "carousels" do
    field :name, :string
    field :is_active, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(carousel, attrs) do
    carousel
    |> cast(attrs, [:name, :is_active])
    |> validate_required([:name, :is_active])
  end
end
