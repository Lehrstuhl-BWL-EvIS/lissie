defmodule LissieWeb.StudentLive.Index do
  use LissieWeb, :live_view

  alias Lissie.Students

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Students
        <:actions>
          <.button variant="primary" navigate={~p"/students/new"}>
            <.icon name="hero-plus" /> New Student
          </.button>
        </:actions>
      </.header>

      <.table
        id="students"
        rows={@streams.students}
        row_click={fn {_id, student} -> JS.navigate(~p"/students/#{student}") end}
      >
        <:col :let={{_id, student}} label="Student">{student.student_id}</:col>
        <:col :let={{_id, student}} label="Lastname">{student.lastname}</:col>
        <:col :let={{_id, student}} label="Firstname">{student.firstname}</:col>
        <:col :let={{_id, student}} label="Date of Birth">{format_date(student.dob)}</:col>
        <:action :let={{_id, student}}>
          <div class="sr-only">
            <.link navigate={~p"/students/#{student}"}>Show</.link>
          </div>
          <.link navigate={~p"/students/#{student}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, student}}>
          <.link
            phx-click={JS.push("delete", value: %{id: student.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Students")
     |> stream(:students, Students.list_students())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student = Students.get_student!(id)
    {:ok, _} = Students.delete_student(student)

    {:noreply, stream_delete(socket, :students, student)}
  end

  defp format_date(nil), do: "N/A"
  defp format_date(date), do: Timex.format!(date, "{D}.{M}.{YYYY}")
end
