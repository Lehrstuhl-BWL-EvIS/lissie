defmodule LissieWeb.StudentLive.Show do
  use LissieWeb, :live_view

  alias Lissie.Students

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
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
        <:item title="Dob">{@student.dob}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Students.subscribe_students(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Student")
     |> assign(:student, Students.get_student!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %Lissie.Students.Student{id: id} = student},
        %{assigns: %{student: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :student, student)}
  end

  def handle_info(
        {:deleted, %Lissie.Students.Student{id: id}},
        %{assigns: %{student: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current student was deleted.")
     |> push_navigate(to: ~p"/students")}
  end

  def handle_info({type, %Lissie.Students.Student{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, socket}
  end
end
