defmodule GalacticCommand.PlanetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GalacticCommand.Planets` context.
  """

  @doc """
  Generate a planet.
  """
  def planet_fixture(attrs \\ %{}) do
    {:ok, planet} =
      attrs
      |> Enum.into(%{
        distance: 42,
        name: "some name",
        size: 42
      })
      |> GalacticCommand.Planets.create_planet()

    planet
  end
end
