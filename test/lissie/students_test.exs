defmodule Lissie.StudentsTest do
  use Lissie.DataCase

  alias Lissie.Students

  describe "students" do
    alias Lissie.Students.Student

    import Lissie.StudentsFixtures

    @invalid_attrs %{student_id: nil, firstname: nil, lastname: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{student_id: "some student_id", firstname: "some firstname", lastname: "some lastname"}

      assert {:ok, %Student{} = student} = Students.create_student(valid_attrs)
      assert student.student_id == "some student_id"
      assert student.firstname == "some firstname"
      assert student.lastname == "some lastname"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{student_id: "some updated student_id", firstname: "some updated firstname", lastname: "some updated lastname"}

      assert {:ok, %Student{} = student} = Students.update_student(student, update_attrs)
      assert student.student_id == "some updated student_id"
      assert student.firstname == "some updated firstname"
      assert student.lastname == "some updated lastname"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
