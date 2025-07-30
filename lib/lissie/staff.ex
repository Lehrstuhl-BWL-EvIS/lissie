defmodule Lissie.Staff do
  @moduledoc """
  The Staff context.
  """

  import Ecto.Query, warn: false
  alias Lissie.Repo

  alias Lissie.Staff.Advisor

  @doc """
  Returns the list of advisors.

  ## Examples

      iex> list_advisors()
      [%Advisor{}, ...]

  """
  def list_advisors do
    Repo.all(Advisor)
  end

  @doc """
  Gets a single advisor.

  Raises `Ecto.NoResultsError` if the Advisor does not exist.

  ## Examples

      iex> get_advisor!(123)
      %Advisor{}

      iex> get_advisor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_advisor!(id), do: Repo.get!(Advisor, id)

  @doc """
  Creates a advisor.

  ## Examples

      iex> create_advisor(%{field: value})
      {:ok, %Advisor{}}

      iex> create_advisor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_advisor(attrs) do
    %Advisor{}
    |> Advisor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a advisor.

  ## Examples

      iex> update_advisor(advisor, %{field: new_value})
      {:ok, %Advisor{}}

      iex> update_advisor(advisor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_advisor(%Advisor{} = advisor, attrs) do
    advisor
    |> Advisor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a advisor.

  ## Examples

      iex> delete_advisor(advisor)
      {:ok, %Advisor{}}

      iex> delete_advisor(advisor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_advisor(%Advisor{} = advisor) do
    Repo.delete(advisor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking advisor changes.

  ## Examples

      iex> change_advisor(advisor)
      %Ecto.Changeset{data: %Advisor{}}

  """
  def change_advisor(%Advisor{} = advisor, attrs \\ %{}) do
    Advisor.changeset(advisor, attrs)
  end

  alias Lissie.Staff.Supervisor

  @doc """
  Returns the list of supervisors.

  ## Examples

      iex> list_supervisors()
      [%Supervisor{}, ...]

  """
  def list_supervisors do
    Repo.all(Supervisor)
  end

  @doc """
  Gets a single supervisor.

  Raises `Ecto.NoResultsError` if the Supervisor does not exist.

  ## Examples

      iex> get_supervisor!(123)
      %Supervisor{}

      iex> get_supervisor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supervisor!(id), do: Repo.get!(Supervisor, id)

  @doc """
  Creates a supervisor.

  ## Examples

      iex> create_supervisor(%{field: value})
      {:ok, %Supervisor{}}

      iex> create_supervisor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supervisor(attrs) do
    %Supervisor{}
    |> Supervisor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supervisor.

  ## Examples

      iex> update_supervisor(supervisor, %{field: new_value})
      {:ok, %Supervisor{}}

      iex> update_supervisor(supervisor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supervisor(%Supervisor{} = supervisor, attrs) do
    supervisor
    |> Supervisor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supervisor.

  ## Examples

      iex> delete_supervisor(supervisor)
      {:ok, %Supervisor{}}

      iex> delete_supervisor(supervisor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supervisor(%Supervisor{} = supervisor) do
    Repo.delete(supervisor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supervisor changes.

  ## Examples

      iex> change_supervisor(supervisor)
      %Ecto.Changeset{data: %Supervisor{}}

  """
  def change_supervisor(%Supervisor{} = supervisor, attrs \\ %{}) do
    Supervisor.changeset(supervisor, attrs)
  end
end
