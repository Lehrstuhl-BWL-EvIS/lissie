defmodule Lissie.StudentsTest do
  use Lissie.DataCase

  alias Lissie.Students

  describe "students" do
    alias Lissie.Students.Student

    import Lissie.AccountsFixtures, only: [user_scope_fixture: 0]
    import Lissie.StudentsFixtures

    @invalid_attrs %{student_id: nil, firstname: nil, lastname: nil, dob: nil}

    test "list_students/1 returns all scoped students" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      student = student_fixture(scope)
      other_student = student_fixture(other_scope)
      assert Students.list_students(scope) == [student]
      assert Students.list_students(other_scope) == [other_student]
    end

    test "get_student!/2 returns the student with given id" do
      scope = user_scope_fixture()
      student = student_fixture(scope)
      other_scope = user_scope_fixture()
      assert Students.get_student!(scope, student.id) == student
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(other_scope, student.id) end
    end

    test "create_student/2 with valid data creates a student" do
      valid_attrs = %{student_id: "some student_id", firstname: "some firstname", lastname: "some lastname", dob: ~D[2025-07-16]}
      scope = user_scope_fixture()

      assert {:ok, %Student{} = student} = Students.create_student(scope, valid_attrs)
      assert student.student_id == "some student_id"
      assert student.firstname == "some firstname"
      assert student.lastname == "some lastname"
      assert student.dob == ~D[2025-07-16]
      assert student.user_id == scope.user.id
    end

    test "create_student/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.create_student(scope, @invalid_attrs)
    end

    test "update_student/3 with valid data updates the student" do
      scope = user_scope_fixture()
      student = student_fixture(scope)
      update_attrs = %{student_id: "some updated student_id", firstname: "some updated firstname", lastname: "some updated lastname", dob: ~D[2025-07-17]}

      assert {:ok, %Student{} = student} = Students.update_student(scope, student, update_attrs)
      assert student.student_id == "some updated student_id"
      assert student.firstname == "some updated firstname"
      assert student.lastname == "some updated lastname"
      assert student.dob == ~D[2025-07-17]
    end

    test "update_student/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      student = student_fixture(scope)

      assert_raise MatchError, fn ->
        Students.update_student(other_scope, student, %{})
      end
    end

    test "update_student/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      student = student_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Students.update_student(scope, student, @invalid_attrs)
      assert student == Students.get_student!(scope, student.id)
    end

    test "delete_student/2 deletes the student" do
      scope = user_scope_fixture()
      student = student_fixture(scope)
      assert {:ok, %Student{}} = Students.delete_student(scope, student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(scope, student.id) end
    end

    test "delete_student/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      student = student_fixture(scope)
      assert_raise MatchError, fn -> Students.delete_student(other_scope, student) end
    end

    test "change_student/2 returns a student changeset" do
      scope = user_scope_fixture()
      student = student_fixture(scope)
      assert %Ecto.Changeset{} = Students.change_student(scope, student)
    end
  end
end
