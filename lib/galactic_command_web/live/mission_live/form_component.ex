defmodule GalacticCommandWeb.MissionLive.FormComponent do
  use GalacticCommandWeb, :live_component

  alias GalacticCommand.Missions
  alias GalacticCommand.Missions.Mission
  alias GalacticCommand.Planets

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage mission records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="mission-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          options={
            Ecto.Enum.values(
              Mission,
              :status
            )
          }
        />
        <div class="flex flex-row items-end space-x-4 " id="destination-select">
          <div class="w-4/5">
            <.input
              field={@form[:destination_id]}
              type="select"
              label="Destination"
              options={
                Planets.list_planets()
                |> Enum.map(&{&1.name, &1.id})
              }
            />
          </div>
          <div class="w-1/5">
            <.link patch={~p"/planets/new"}>
              <.button>New Planet</.button>
            </.link>
          </div>
        </div>
        <:actions>
          <.button type="submit" phx-disable-with="Saving...">Save Mission</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{mission: mission} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Missions.change_mission(mission))
     end)}
  end

  @impl true
  def handle_event("validate", %{"mission" => mission_params}, socket) do
    changeset = Missions.change_mission(socket.assigns.mission, mission_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"mission" => mission_params}, socket) do
    save_mission(socket, socket.assigns.action, mission_params)
  end

  defp save_mission(socket, :edit, mission_params) do
    case Missions.update_mission(socket.assigns.mission, mission_params) do
      {:ok, mission} ->
        notify_parent({:saved, mission})

        {:noreply,
         socket
         |> put_flash(:info, "Mission updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_mission(socket, :new, mission_params) do
    case Missions.create_mission(mission_params) do
      {:ok, mission} ->
        notify_parent({:saved, mission})

        {:noreply,
         socket
         |> put_flash(:info, "Mission created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
