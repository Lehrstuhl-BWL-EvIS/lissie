defmodule LissieWeb.AdvisorLive.Index do
  use LissieWeb, :live_view

  alias Lissie.Staff

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Advisors
        <:actions>
          <.button variant="primary" navigate={~p"/advisors/new"}>
            <.icon name="hero-plus" /> New Advisor
          </.button>
        </:actions>
      </.header>

      <.table
        id="advisors"
        rows={@streams.advisors}
        row_click={fn {_id, advisor} -> JS.navigate(~p"/advisors/#{advisor}") end}
      >
        <:col :let={{_id, advisor}} label="Firstname">{advisor.firstname}</:col>
        <:col :let={{_id, advisor}} label="Lastname">{advisor.lastname}</:col>
        <:action :let={{_id, advisor}}>
          <div class="sr-only">
            <.link navigate={~p"/advisors/#{advisor}"}>Show</.link>
          </div>
          <.link navigate={~p"/advisors/#{advisor}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, advisor}}>
          <.link
            phx-click={JS.push("delete", value: %{id: advisor.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Advisors")
     |> stream(:advisors, Staff.list_advisors())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    advisor = Staff.get_advisor!(id)
    {:ok, _} = Staff.delete_advisor(advisor)

    {:noreply, stream_delete(socket, :advisors, advisor)}
  end
end
