defmodule LissieWeb.AdvisorLive.Show do
  use LissieWeb, :live_view

  alias Lissie.Staff

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Advisor {@advisor.id}
        <:subtitle>This is a advisor record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/advisors"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/advisors/#{@advisor}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit advisor
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Firstname">{@advisor.firstname}</:item>
        <:item title="Lastname">{@advisor.lastname}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Advisor")
     |> assign(:advisor, Staff.get_advisor!(id))}
  end
end
