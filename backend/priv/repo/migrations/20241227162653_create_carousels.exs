defmodule CarouselBuilder.Repo.Migrations.CreateCarousels do
  use Ecto.Migration

  def change do
    create table(:carousels) do
      add :name, :string, null: false
      add :is_active, :boolean, default: true, null: false

      timestamps()
    end
  end
end
