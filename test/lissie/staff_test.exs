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

  describe "supervisors" do
    alias Lissie.Staff.Supervisor

    import Lissie.StaffFixtures

    @invalid_attrs %{salutation: nil, firstname: nil, lastname: nil}

    test "list_supervisors/0 returns all supervisors" do
      supervisor = supervisor_fixture()
      assert Staff.list_supervisors() == [supervisor]
    end

    test "get_supervisor!/1 returns the supervisor with given id" do
      supervisor = supervisor_fixture()
      assert Staff.get_supervisor!(supervisor.id) == supervisor
    end

    test "create_supervisor/1 with valid data creates a supervisor" do
      valid_attrs = %{salutation: "some salutation", firstname: "some firstname", lastname: "some lastname"}

      assert {:ok, %Supervisor{} = supervisor} = Staff.create_supervisor(valid_attrs)
      assert supervisor.salutation == "some salutation"
      assert supervisor.firstname == "some firstname"
      assert supervisor.lastname == "some lastname"
    end

    test "create_supervisor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_supervisor(@invalid_attrs)
    end

    test "update_supervisor/2 with valid data updates the supervisor" do
      supervisor = supervisor_fixture()
      update_attrs = %{salutation: "some updated salutation", firstname: "some updated firstname", lastname: "some updated lastname"}

      assert {:ok, %Supervisor{} = supervisor} = Staff.update_supervisor(supervisor, update_attrs)
      assert supervisor.salutation == "some updated salutation"
      assert supervisor.firstname == "some updated firstname"
      assert supervisor.lastname == "some updated lastname"
    end

    test "update_supervisor/2 with invalid data returns error changeset" do
      supervisor = supervisor_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_supervisor(supervisor, @invalid_attrs)
      assert supervisor == Staff.get_supervisor!(supervisor.id)
    end

    test "delete_supervisor/1 deletes the supervisor" do
      supervisor = supervisor_fixture()
      assert {:ok, %Supervisor{}} = Staff.delete_supervisor(supervisor)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_supervisor!(supervisor.id) end
    end

    test "change_supervisor/1 returns a supervisor changeset" do
      supervisor = supervisor_fixture()
      assert %Ecto.Changeset{} = Staff.change_supervisor(supervisor)
    end
  end

  describe "supervisors" do
    alias Lissie.Staff.Supervisor

    import Lissie.StaffFixtures

    @invalid_attrs %{email: nil, salutation: nil, firstname: nil, lastname: nil}

    test "list_supervisors/0 returns all supervisors" do
      supervisor = supervisor_fixture()
      assert Staff.list_supervisors() == [supervisor]
    end

    test "get_supervisor!/1 returns the supervisor with given id" do
      supervisor = supervisor_fixture()
      assert Staff.get_supervisor!(supervisor.id) == supervisor
    end

    test "create_supervisor/1 with valid data creates a supervisor" do
      valid_attrs = %{email: "some email", salutation: "some salutation", firstname: "some firstname", lastname: "some lastname"}

      assert {:ok, %Supervisor{} = supervisor} = Staff.create_supervisor(valid_attrs)
      assert supervisor.email == "some email"
      assert supervisor.salutation == "some salutation"
      assert supervisor.firstname == "some firstname"
      assert supervisor.lastname == "some lastname"
    end

    test "create_supervisor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_supervisor(@invalid_attrs)
    end

    test "update_supervisor/2 with valid data updates the supervisor" do
      supervisor = supervisor_fixture()
      update_attrs = %{email: "some updated email", salutation: "some updated salutation", firstname: "some updated firstname", lastname: "some updated lastname"}

      assert {:ok, %Supervisor{} = supervisor} = Staff.update_supervisor(supervisor, update_attrs)
      assert supervisor.email == "some updated email"
      assert supervisor.salutation == "some updated salutation"
      assert supervisor.firstname == "some updated firstname"
      assert supervisor.lastname == "some updated lastname"
    end

    test "update_supervisor/2 with invalid data returns error changeset" do
      supervisor = supervisor_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_supervisor(supervisor, @invalid_attrs)
      assert supervisor == Staff.get_supervisor!(supervisor.id)
    end

    test "delete_supervisor/1 deletes the supervisor" do
      supervisor = supervisor_fixture()
      assert {:ok, %Supervisor{}} = Staff.delete_supervisor(supervisor)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_supervisor!(supervisor.id) end
    end

    test "change_supervisor/1 returns a supervisor changeset" do
      supervisor = supervisor_fixture()
      assert %Ecto.Changeset{} = Staff.change_supervisor(supervisor)
    end
  end
end
