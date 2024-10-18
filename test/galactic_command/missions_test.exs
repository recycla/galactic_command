defmodule GalacticCommand.MissionsTest do
  use GalacticCommand.DataCase

  alias GalacticCommand.Missions

  describe "missions" do
    alias GalacticCommand.Missions.Mission

    import GalacticCommand.MissionsFixtures
    import GalacticCommand.PlanetsFixtures

    @invalid_attrs %{name: nil}

    test "list_missions/0 returns all missions" do
      mission = mission_fixture()
      assert Missions.list_missions() == [mission]
    end

    test "get_mission!/1 returns the mission with given id" do
      mission = mission_fixture()
      assert Missions.get_mission!(mission.id).id == mission.id
    end

    test "create_mission/1 with valid data creates a mission" do
      planet = planet_fixture()

      valid_attrs = %{name: "some name", status: "planned", destination_id: planet.id}

      assert {:ok, %Mission{} = mission} = Missions.create_mission(valid_attrs)
      assert mission.name == "some name"
    end

    test "create_mission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Missions.create_mission(@invalid_attrs)
    end

    test "update_mission/2 with valid data updates the mission" do
      mission = mission_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Mission{} = mission} = Missions.update_mission(mission, update_attrs)
      assert mission.name == "some updated name"
    end

    test "update_mission/2 with invalid data returns error changeset" do
      mission = mission_fixture()
      assert {:error, %Ecto.Changeset{}} = Missions.update_mission(mission, @invalid_attrs)
      assert mission.id == Missions.get_mission!(mission.id).id
    end

    test "delete_mission/1 deletes the mission" do
      mission = mission_fixture()
      assert {:ok, %Mission{}} = Missions.delete_mission(mission)
      assert_raise Ecto.NoResultsError, fn -> Missions.get_mission!(mission.id) end
    end

    test "change_mission/1 returns a mission changeset" do
      mission = mission_fixture()
      assert %Ecto.Changeset{} = Missions.change_mission(mission)
    end
  end
end
