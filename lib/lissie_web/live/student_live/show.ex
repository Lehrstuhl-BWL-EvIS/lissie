defmodule LissieWeb.StudentLive.Show do
  use LissieWeb, :live_view

  # import Timex

  alias Lissie.Students

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Student {@student.id}
        <:subtitle>This is a student record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/students"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/students/#{@student}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit student
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Student">{@student.student_id}</:item>
        <:item title="Firstname">{@student.firstname}</:item>
        <:item title="Lastname">{@student.lastname}</:item>
        <:item title="Date of Birth">{format_date(@student.dob)}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Student")
     |> assign(:student, Students.get_student!(id))}
  end

  defp format_date(nil), do: "N/A"
  defp format_date(date), do: Timex.format!(date, "{D}.{Mfull}.{YYYY}")
end
