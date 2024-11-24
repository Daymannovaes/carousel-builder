defmodule CarouselBuilder.Repo.Migrations.CreateCarousels do
  use Ecto.Migration

  def change do
    create table(:carousels) do
      add :carousel, :map, default: %{}, null: false
      add :status, :boolean, default: true, null: false

      timestamps()
    end
  end
end
