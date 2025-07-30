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
end
