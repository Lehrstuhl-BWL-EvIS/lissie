defmodule Lissie.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lissie.Students` context.
  """

  @doc """
  Generate a unique student student_id.
  """
  def unique_student_student_id, do: "some student_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a student.
  """
  def student_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        dob: ~D[2025-07-16],
        firstname: "some firstname",
        lastname: "some lastname",
        student_id: unique_student_student_id()
      })

    {:ok, student} = Lissie.Students.create_student(scope, attrs)
    student
  end
end
