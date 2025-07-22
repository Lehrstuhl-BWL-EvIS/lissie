defmodule LissieWeb.StudentLiveTest do
  use LissieWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lissie.StudentsFixtures

  @create_attrs %{student_id: "some student_id", firstname: "some firstname", lastname: "some lastname"}
  @update_attrs %{student_id: "some updated student_id", firstname: "some updated firstname", lastname: "some updated lastname"}
  @invalid_attrs %{student_id: nil, firstname: nil, lastname: nil}
  defp create_student(_) do
    student = student_fixture()

    %{student: student}
  end

  describe "Index" do
    setup [:create_student]

    test "lists all students", %{conn: conn, student: student} do
      {:ok, _index_live, html} = live(conn, ~p"/students")

      assert html =~ "Listing Students"
      assert html =~ student.student_id
    end

    test "saves new student", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Student")
               |> render_click()
               |> follow_redirect(conn, ~p"/students/new")

      assert render(form_live) =~ "New Student"

      assert form_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#student-form", student: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/students")

      html = render(index_live)
      assert html =~ "Student created successfully"
      assert html =~ "some student_id"
    end

    test "updates student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#students-#{student.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/students/#{student}/edit")

      assert render(form_live) =~ "Edit Student"

      assert form_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#student-form", student: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/students")

      html = render(index_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated student_id"
    end

    test "deletes student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{student.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#students-#{student.id}")
    end
  end

  describe "Show" do
    setup [:create_student]

    test "displays student", %{conn: conn, student: student} do
      {:ok, _show_live, html} = live(conn, ~p"/students/#{student}")

      assert html =~ "Show Student"
      assert html =~ student.student_id
    end

    test "updates student and returns to show", %{conn: conn, student: student} do
      {:ok, show_live, _html} = live(conn, ~p"/students/#{student}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/students/#{student}/edit?return_to=show")

      assert render(form_live) =~ "Edit Student"

      assert form_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#student-form", student: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/students/#{student}")

      html = render(show_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated student_id"
    end
  end
end
