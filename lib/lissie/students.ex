defmodule Lissie.Students do
  @moduledoc """
  The Students context.
  """

  import Ecto.Query, warn: false
  alias Lissie.Repo

  alias Lissie.Students.Student
  alias Lissie.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any student changes.

  The broadcasted messages match the pattern:

    * {:created, %Student{}}
    * {:updated, %Student{}}
    * {:deleted, %Student{}}

  """
  def subscribe_students(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Lissie.PubSub, "user:#{key}:students")
  end

  defp broadcast(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Lissie.PubSub, "user:#{key}:students", message)
  end

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students(scope)
      [%Student{}, ...]

  """
  def list_students(%Scope{} = scope) do
    Repo.all_by(Student, user_id: scope.user.id)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(%Scope{} = scope, id) do
    Repo.get_by!(Student, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(%Scope{} = scope, attrs) do
    with {:ok, student = %Student{}} <-
           %Student{}
           |> Student.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast(scope, {:created, student})
      {:ok, student}
    end
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Scope{} = scope, %Student{} = student, attrs) do
    true = student.user_id == scope.user.id

    with {:ok, student = %Student{}} <-
           student
           |> Student.changeset(attrs, scope)
           |> Repo.update() do
      broadcast(scope, {:updated, student})
      {:ok, student}
    end
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Scope{} = scope, %Student{} = student) do
    true = student.user_id == scope.user.id

    with {:ok, student = %Student{}} <-
           Repo.delete(student) do
      broadcast(scope, {:deleted, student})
      {:ok, student}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Scope{} = scope, %Student{} = student, attrs \\ %{}) do
    true = student.user_id == scope.user.id

    Student.changeset(student, attrs, scope)
  end
end
