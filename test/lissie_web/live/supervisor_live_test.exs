defmodule LissieWeb.SupervisorLiveTest do
  use LissieWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lissie.StaffFixtures

  @create_attrs %{email: "some email", salutation: "some salutation", firstname: "some firstname", lastname: "some lastname"}
  @update_attrs %{email: "some updated email", salutation: "some updated salutation", firstname: "some updated firstname", lastname: "some updated lastname"}
  @invalid_attrs %{email: nil, salutation: nil, firstname: nil, lastname: nil}
  defp create_supervisor(_) do
    supervisor = supervisor_fixture()

    %{supervisor: supervisor}
  end

  describe "Index" do
    setup [:create_supervisor]

    test "lists all supervisors", %{conn: conn, supervisor: supervisor} do
      {:ok, _index_live, html} = live(conn, ~p"/supervisors")

      assert html =~ "Listing Supervisors"
      assert html =~ supervisor.email
    end

    test "saves new supervisor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/supervisors")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Supervisor")
               |> render_click()
               |> follow_redirect(conn, ~p"/supervisors/new")

      assert render(form_live) =~ "New Supervisor"

      assert form_live
             |> form("#supervisor-form", supervisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#supervisor-form", supervisor: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/supervisors")

      html = render(index_live)
      assert html =~ "Supervisor created successfully"
      assert html =~ "some email"
    end

    test "updates supervisor in listing", %{conn: conn, supervisor: supervisor} do
      {:ok, index_live, _html} = live(conn, ~p"/supervisors")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#supervisors-#{supervisor.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/supervisors/#{supervisor}/edit")

      assert render(form_live) =~ "Edit Supervisor"

      assert form_live
             |> form("#supervisor-form", supervisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#supervisor-form", supervisor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/supervisors")

      html = render(index_live)
      assert html =~ "Supervisor updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes supervisor in listing", %{conn: conn, supervisor: supervisor} do
      {:ok, index_live, _html} = live(conn, ~p"/supervisors")

      assert index_live |> element("#supervisors-#{supervisor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#supervisors-#{supervisor.id}")
    end
  end

  describe "Show" do
    setup [:create_supervisor]

    test "displays supervisor", %{conn: conn, supervisor: supervisor} do
      {:ok, _show_live, html} = live(conn, ~p"/supervisors/#{supervisor}")

      assert html =~ "Show Supervisor"
      assert html =~ supervisor.email
    end

    test "updates supervisor and returns to show", %{conn: conn, supervisor: supervisor} do
      {:ok, show_live, _html} = live(conn, ~p"/supervisors/#{supervisor}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/supervisors/#{supervisor}/edit?return_to=show")

      assert render(form_live) =~ "Edit Supervisor"

      assert form_live
             |> form("#supervisor-form", supervisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#supervisor-form", supervisor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/supervisors/#{supervisor}")

      html = render(show_live)
      assert html =~ "Supervisor updated successfully"
      assert html =~ "some updated email"
    end
  end
end
