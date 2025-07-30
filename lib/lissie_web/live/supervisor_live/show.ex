defmodule LissieWeb.SupervisorLive.Show do
  use LissieWeb, :live_view

  alias Lissie.Staff

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Supervisor {@supervisor.id}
        <:subtitle>This is a supervisor record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/supervisors"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/supervisors/#{@supervisor}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit supervisor
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Email">{@supervisor.email}</:item>
        <:item title="Salutation">{@supervisor.salutation}</:item>
        <:item title="Firstname">{@supervisor.firstname}</:item>
        <:item title="Lastname">{@supervisor.lastname}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Supervisor")
     |> assign(:supervisor, Staff.get_supervisor!(id))}
  end
end
