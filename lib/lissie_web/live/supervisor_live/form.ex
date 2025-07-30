defmodule LissieWeb.SupervisorLive.Form do
  use LissieWeb, :live_view

  alias Lissie.Staff
  alias Lissie.Staff.Supervisor

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage supervisor records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="supervisor-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:salutation]} type="text" label="Salutation" />
        <.input field={@form[:firstname]} type="text" label="Firstname" />
        <.input field={@form[:lastname]} type="text" label="Lastname" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Supervisor</.button>
          <.button navigate={return_path(@return_to, @supervisor)}>Cancel</.button>
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
    supervisor = Staff.get_supervisor!(id)

    socket
    |> assign(:page_title, "Edit Supervisor")
    |> assign(:supervisor, supervisor)
    |> assign(:form, to_form(Staff.change_supervisor(supervisor)))
  end

  defp apply_action(socket, :new, _params) do
    supervisor = %Supervisor{}

    socket
    |> assign(:page_title, "New Supervisor")
    |> assign(:supervisor, supervisor)
    |> assign(:form, to_form(Staff.change_supervisor(supervisor)))
  end

  @impl true
  def handle_event("validate", %{"supervisor" => supervisor_params}, socket) do
    changeset = Staff.change_supervisor(socket.assigns.supervisor, supervisor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"supervisor" => supervisor_params}, socket) do
    save_supervisor(socket, socket.assigns.live_action, supervisor_params)
  end

  defp save_supervisor(socket, :edit, supervisor_params) do
    case Staff.update_supervisor(socket.assigns.supervisor, supervisor_params) do
      {:ok, supervisor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supervisor updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, supervisor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_supervisor(socket, :new, supervisor_params) do
    case Staff.create_supervisor(supervisor_params) do
      {:ok, supervisor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supervisor created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, supervisor))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _supervisor), do: ~p"/supervisors"
  defp return_path("show", supervisor), do: ~p"/supervisors/#{supervisor}"
end
