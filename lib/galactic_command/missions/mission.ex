defmodule GalacticCommand.Missions.Mission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "missions" do
    field :name, :string
    field :status, Ecto.Enum, values: [:planned, :scrapped, :failed, :success]
    belongs_to :destination, GalacticCommand.Planets.Planet

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mission, attrs) do
    mission
    |> cast(attrs, [:name, :status, :destination_id])
    |> assoc_constraint(:destination)
    |> validate_required([:name, :status, :destination_id])
  end
end
