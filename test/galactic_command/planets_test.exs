defmodule GalacticCommand.PlanetsTest do
  use GalacticCommand.DataCase

  alias GalacticCommand.Planets

  describe "planets" do
    alias GalacticCommand.Planets.Planet

    import GalacticCommand.PlanetsFixtures

    @invalid_attrs %{name: nil, size: nil, distance: nil}

    test "list_planets/0 returns all planets" do
      planet = planet_fixture()
      assert Planets.list_planets() == [planet]
    end

    test "get_planet!/1 returns the planet with given id" do
      planet = planet_fixture()
      assert Planets.get_planet!(planet.id) == planet
    end

    test "create_planet/1 with valid data creates a planet" do
      valid_attrs = %{name: "some name", size: 42, distance: 42}

      assert {:ok, %Planet{} = planet} = Planets.create_planet(valid_attrs)
      assert planet.name == "some name"
      assert planet.size == 42
      assert planet.distance == 42
    end

    test "create_planet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planets.create_planet(@invalid_attrs)
    end

    test "update_planet/2 with valid data updates the planet" do
      planet = planet_fixture()
      update_attrs = %{name: "some updated name", size: 43, distance: 43}

      assert {:ok, %Planet{} = planet} = Planets.update_planet(planet, update_attrs)
      assert planet.name == "some updated name"
      assert planet.size == 43
      assert planet.distance == 43
    end

    test "update_planet/2 with invalid data returns error changeset" do
      planet = planet_fixture()
      assert {:error, %Ecto.Changeset{}} = Planets.update_planet(planet, @invalid_attrs)
      assert planet == Planets.get_planet!(planet.id)
    end

    test "delete_planet/1 deletes the planet" do
      planet = planet_fixture()
      assert {:ok, %Planet{}} = Planets.delete_planet(planet)
      assert_raise Ecto.NoResultsError, fn -> Planets.get_planet!(planet.id) end
    end

    test "change_planet/1 returns a planet changeset" do
      planet = planet_fixture()
      assert %Ecto.Changeset{} = Planets.change_planet(planet)
    end
  end
end
