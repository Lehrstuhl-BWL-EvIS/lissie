defmodule LissieWeb.SupervisorLive.Index do
  use LissieWeb, :live_view

  alias Lissie.Staff

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Supervisors
        <:actions>
          <.button variant="primary" navigate={~p"/supervisors/new"}>
            <.icon name="hero-plus" /> New Supervisor
          </.button>
        </:actions>
      </.header>

      <.table
        id="supervisors"
        rows={@streams.supervisors}
        row_click={fn {_id, supervisor} -> JS.navigate(~p"/supervisors/#{supervisor}") end}
      >
        <:col :let={{_id, supervisor}} label="Email">{supervisor.email}</:col>
        <:col :let={{_id, supervisor}} label="Salutation">{supervisor.salutation}</:col>
        <:col :let={{_id, supervisor}} label="Firstname">{supervisor.firstname}</:col>
        <:col :let={{_id, supervisor}} label="Lastname">{supervisor.lastname}</:col>
        <:action :let={{_id, supervisor}}>
          <div class="sr-only">
            <.link navigate={~p"/supervisors/#{supervisor}"}>Show</.link>
          </div>
          <.link navigate={~p"/supervisors/#{supervisor}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, supervisor}}>
          <.link
            phx-click={JS.push("delete", value: %{id: supervisor.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Supervisors")
     |> stream(:supervisors, Staff.list_supervisors())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    supervisor = Staff.get_supervisor!(id)
    {:ok, _} = Staff.delete_supervisor(supervisor)

    {:noreply, stream_delete(socket, :supervisors, supervisor)}
  end
end
