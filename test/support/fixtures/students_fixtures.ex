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
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname",
        student_id: unique_student_student_id()
      })
      |> Lissie.Students.create_student()

    student
  end
end
