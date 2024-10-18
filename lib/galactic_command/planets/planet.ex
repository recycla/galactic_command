defmodule GalacticCommand.Planets.Planet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "planets" do
    field :name, :string
    field :size, :integer
    field :distance, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(planet, attrs) do
    planet
    |> cast(attrs, [:name, :distance, :size])
    |> validate_required([:name, :distance, :size])
  end
end
