defmodule LissieWeb.AdvisorLive.Form do
  use LissieWeb, :live_view

  alias Lissie.Staff
  alias Lissie.Staff.Advisor

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage advisor records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="advisor-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:firstname]} type="text" label="Firstname" />
        <.input field={@form[:lastname]} type="text" label="Lastname" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Advisor</.button>
          <.button navigate={return_path(@return_to, @advisor)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    advisor = Staff.get_advisor!(id)

    socket
    |> assign(:page_title, "Edit Advisor")
    |> assign(:advisor, advisor)
    |> assign(:form, to_form(Staff.change_advisor(advisor)))
  end

  defp apply_action(socket, :new, _params) do
    advisor = %Advisor{}

    socket
    |> assign(:page_title, "New Advisor")
    |> assign(:advisor, advisor)
    |> assign(:form, to_form(Staff.change_advisor(advisor)))
  end

  @impl true
  def handle_event("validate", %{"advisor" => advisor_params}, socket) do
    changeset = Staff.change_advisor(socket.assigns.advisor, advisor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"advisor" => advisor_params}, socket) do
    save_advisor(socket, socket.assigns.live_action, advisor_params)
  end

  defp save_advisor(socket, :edit, advisor_params) do
    case Staff.update_advisor(socket.assigns.advisor, advisor_params) do
      {:ok, advisor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Advisor updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, advisor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_advisor(socket, :new, advisor_params) do
    case Staff.create_advisor(advisor_params) do
      {:ok, advisor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Advisor created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, advisor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _advisor), do: ~p"/advisors"
  defp return_path("show", advisor), do: ~p"/advisors/#{advisor}"
end
