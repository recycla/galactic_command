defmodule GalacticCommand.Repo.Migrations.CreateMissions do
  use Ecto.Migration

  def change do
    create table(:missions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :status, :string, null: false

      add :destination_id, references(:planets, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps(type: :utc_datetime)
    end

    create index(:missions, [:destination_id])
  end
end
