defmodule CarouselBuilder.Repo.Migrations.CreateSlides do
  use Ecto.Migration

  def change do
    create table(:slides) do
      add :background_color, :string, null: false
      add :font_color, :string, null: false
      add :position, :integer, null: false
      add :quill_delta_content, :text
      add :carousel_id, references(:carousels, on_delete: :all)

      timestamps()
    end

    create index(:slides, [:carousel_id])
  end
end
