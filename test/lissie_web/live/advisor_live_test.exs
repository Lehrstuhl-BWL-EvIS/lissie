defmodule LissieWeb.AdvisorLiveTest do
  use LissieWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lissie.StaffFixtures

  @create_attrs %{firstname: "some firstname", lastname: "some lastname"}
  @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname"}
  @invalid_attrs %{firstname: nil, lastname: nil}
  defp create_advisor(_) do
    advisor = advisor_fixture()

    %{advisor: advisor}
  end

  describe "Index" do
    setup [:create_advisor]

    test "lists all advisors", %{conn: conn, advisor: advisor} do
      {:ok, _index_live, html} = live(conn, ~p"/advisors")

      assert html =~ "Listing Advisors"
      assert html =~ advisor.firstname
    end

    test "saves new advisor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/advisors")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Advisor")
               |> render_click()
               |> follow_redirect(conn, ~p"/advisors/new")

      assert render(form_live) =~ "New Advisor"

      assert form_live
             |> form("#advisor-form", advisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#advisor-form", advisor: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/advisors")

      html = render(index_live)
      assert html =~ "Advisor created successfully"
      assert html =~ "some firstname"
    end

    test "updates advisor in listing", %{conn: conn, advisor: advisor} do
      {:ok, index_live, _html} = live(conn, ~p"/advisors")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#advisors-#{advisor.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/advisors/#{advisor}/edit")

      assert render(form_live) =~ "Edit Advisor"

      assert form_live
             |> form("#advisor-form", advisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#advisor-form", advisor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/advisors")

      html = render(index_live)
      assert html =~ "Advisor updated successfully"
      assert html =~ "some updated firstname"
    end

    test "deletes advisor in listing", %{conn: conn, advisor: advisor} do
      {:ok, index_live, _html} = live(conn, ~p"/advisors")

      assert index_live |> element("#advisors-#{advisor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#advisors-#{advisor.id}")
    end
  end

  describe "Show" do
    setup [:create_advisor]

    test "displays advisor", %{conn: conn, advisor: advisor} do
      {:ok, _show_live, html} = live(conn, ~p"/advisors/#{advisor}")

      assert html =~ "Show Advisor"
      assert html =~ advisor.firstname
    end

    test "updates advisor and returns to show", %{conn: conn, advisor: advisor} do
      {:ok, show_live, _html} = live(conn, ~p"/advisors/#{advisor}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/advisors/#{advisor}/edit?return_to=show")

      assert render(form_live) =~ "Edit Advisor"

      assert form_live
             |> form("#advisor-form", advisor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#advisor-form", advisor: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/advisors/#{advisor}")

      html = render(show_live)
      assert html =~ "Advisor updated successfully"
      assert html =~ "some updated firstname"
    end
  end
end
