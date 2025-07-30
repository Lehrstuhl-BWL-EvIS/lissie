defmodule Lissie.StaffTest do
  use Lissie.DataCase

  alias Lissie.Staff

  describe "advisors" do
    alias Lissie.Staff.Advisor

    import Lissie.StaffFixtures

    @invalid_attrs %{firstname: nil, lastname: nil}

    test "list_advisors/0 returns all advisors" do
      advisor = advisor_fixture()
      assert Staff.list_advisors() == [advisor]
    end

    test "get_advisor!/1 returns the advisor with given id" do
      advisor = advisor_fixture()
      assert Staff.get_advisor!(advisor.id) == advisor
    end

    test "create_advisor/1 with valid data creates a advisor" do
      valid_attrs = %{firstname: "some firstname", lastname: "some lastname"}

      assert {:ok, %Advisor{} = advisor} = Staff.create_advisor(valid_attrs)
      assert advisor.firstname == "some firstname"
      assert advisor.lastname == "some lastname"
    end

    test "create_advisor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_advisor(@invalid_attrs)
    end

    test "update_advisor/2 with valid data updates the advisor" do
      advisor = advisor_fixture()
      update_attrs = %{firstname: "some updated firstname", lastname: "some updated lastname"}

      assert {:ok, %Advisor{} = advisor} = Staff.update_advisor(advisor, update_attrs)
      assert advisor.firstname == "some updated firstname"
      assert advisor.lastname == "some updated lastname"
    end

    test "update_advisor/2 with invalid data returns error changeset" do
      advisor = advisor_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_advisor(advisor, @invalid_attrs)
      assert advisor == Staff.get_advisor!(advisor.id)
    end

    test "delete_advisor/1 deletes the advisor" do
      advisor = advisor_fixture()
      assert {:ok, %Advisor{}} = Staff.delete_advisor(advisor)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_advisor!(advisor.id) end
    end

    test "change_advisor/1 returns a advisor changeset" do
      advisor = advisor_fixture()
      assert %Ecto.Changeset{} = Staff.change_advisor(advisor)
    end
  end
end
