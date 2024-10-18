defmodule GalacticCommandWeb.PlanetLive.Index do
  use GalacticCommandWeb, :live_view

  alias GalacticCommand.Planets
  alias GalacticCommand.Planets.Planet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :planets, Planets.list_planets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Planet")
    |> assign(:planet, Planets.get_planet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Planet")
    |> assign(:planet, %Planet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Planets")
    |> assign(:planet, nil)
  end

  @impl true
  def handle_info({GalacticCommandWeb.PlanetLive.FormComponent, {:saved, planet}}, socket) do
    {:noreply, stream_insert(socket, :planets, planet)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    planet = Planets.get_planet!(id)
    {:ok, _} = Planets.delete_planet(planet)

    {:noreply, stream_delete(socket, :planets, planet)}
  end
end
