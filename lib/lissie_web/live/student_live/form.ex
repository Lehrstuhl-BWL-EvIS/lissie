defmodule LissieWeb.StudentLive.Form do
  use LissieWeb, :live_view

  alias Lissie.Students
  alias Lissie.Students.Student

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage student records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="student-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:student_id]} type="text" label="Student" />
        <.input field={@form[:firstname]} type="text" label="Firstname" />
        <.input field={@form[:lastname]} type="text" label="Lastname" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Student</.button>
          <.button navigate={return_path(@return_to, @student)}>Cancel</.button>
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
    student = Students.get_student!(id)

    socket
    |> assign(:page_title, "Edit Student")
    |> assign(:student, student)
    |> assign(:form, to_form(Students.change_student(student)))
  end

  defp apply_action(socket, :new, _params) do
    student = %Student{}

    socket
    |> assign(:page_title, "New Student")
    |> assign(:student, student)
    |> assign(:form, to_form(Students.change_student(student)))
  end

  @impl true
  def handle_event("validate", %{"student" => student_params}, socket) do
    changeset = Students.change_student(socket.assigns.student, student_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"student" => student_params}, socket) do
    save_student(socket, socket.assigns.live_action, student_params)
  end

  defp save_student(socket, :edit, student_params) do
    case Students.update_student(socket.assigns.student, student_params) do
      {:ok, student} ->
        {:noreply,
         socket
         |> put_flash(:info, "Student updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, student))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_student(socket, :new, student_params) do
    case Students.create_student(student_params) do
      {:ok, student} ->
        {:noreply,
         socket
         |> put_flash(:info, "Student created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, student))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _student), do: ~p"/students"
  defp return_path("show", student), do: ~p"/students/#{student}"
end
