defmodule GalacticCommand.Repo.Migrations.CreatePlanets do
  use Ecto.Migration

  def change do
    create table(:planets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :distance, :integer
      add :size, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
