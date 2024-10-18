defmodule GalacticCommand.MissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GalacticCommand.Missions` context.
  """

  alias GalacticCommand.PlanetsFixtures

  @doc """
  Generate a mission.
  """
  def mission_fixture(attrs \\ %{}) do
    planet = PlanetsFixtures.planet_fixture()

    {:ok, mission} =
      attrs
      |> Enum.into(%{
        name: "some name",
        status: "planned",
        destination_id: planet.id
      })
      |> GalacticCommand.Missions.create_mission()

    mission
  end
end
