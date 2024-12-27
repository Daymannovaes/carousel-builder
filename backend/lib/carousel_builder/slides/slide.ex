defmodule CarouselBuilder.Slides.Slide do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias CarouselBuilder.Carousels.Carousel

  schema "slides" do
    field :position, :integer
    field :background_color, :string
    field :font_color, :string
    field :quill_delta_content, :string

    belongs_to :carousel, Carousel

    timestamps()
  end

  @doc false
  def changeset(slide, attrs) do
    slide
    |> cast(attrs, [:background_color, :font_color, :position, :quill_delta_content, :carousel_id])
    |> validate_required([
      :background_color,
      :font_color,
      :position,
      :quill_delta_content,
      :carousel_id
    ])
  end
end
