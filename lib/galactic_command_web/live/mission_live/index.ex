defmodule GalacticCommandWeb.MissionLive.Index do
  use GalacticCommandWeb, :live_view

  alias GalacticCommand.Missions
  alias GalacticCommand.Missions.Mission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :missions, Missions.list_missions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mission")
    |> assign(:mission, Missions.get_mission!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mission")
    |> assign(:mission, %Mission{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Missions")
    |> assign(:mission, nil)
  end

  @impl true
  def handle_info({GalacticCommandWeb.MissionLive.FormComponent, {:saved, mission}}, socket) do
    {:noreply, stream_insert(socket, :missions, mission)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mission = Missions.get_mission!(id)
    {:ok, _} = Missions.delete_mission(mission)

    {:noreply, stream_delete(socket, :missions, mission)}
  end
end
