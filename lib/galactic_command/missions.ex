defmodule GalacticCommand.Missions do
  @moduledoc """
  The Missions context.
  """

  import Ecto.Query, warn: false
  alias GalacticCommand.Repo

  alias GalacticCommand.Missions.Mission

  @doc """
  Returns the list of missions.

  ## Examples

      iex> list_missions()
      [%Mission{}, ...]

  """
  def list_missions do
    Repo.all(Mission)
  end

  @doc """
  Gets a single mission.

  Raises `Ecto.NoResultsError` if the Mission does not exist.

  ## Examples

      iex> get_mission!(123)
      %Mission{}

      iex> get_mission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mission!(id), do: Repo.get!(Mission, id) |> Repo.preload([:destination])

  @doc """
  Creates a mission.

  ## Examples

      iex> create_mission(%{field: value})
      {:ok, %Mission{}}

      iex> create_mission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mission(attrs \\ %{}) do
    %Mission{}
    |> Mission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mission.

  ## Examples

      iex> update_mission(mission, %{field: new_value})
      {:ok, %Mission{}}

      iex> update_mission(mission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mission(%Mission{} = mission, attrs) do
    mission
    |> Mission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mission.

  ## Examples

      iex> delete_mission(mission)
      {:ok, %Mission{}}

      iex> delete_mission(mission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mission(%Mission{} = mission) do
    Repo.delete(mission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mission changes.

  ## Examples

      iex> change_mission(mission)
      %Ecto.Changeset{data: %Mission{}}

  """
  def change_mission(%Mission{} = mission, attrs \\ %{}) do
    Mission.changeset(mission, attrs)
  end
end
