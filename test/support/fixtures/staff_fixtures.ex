defmodule Lissie.StaffFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lissie.Staff` context.
  """

  @doc """
  Generate a advisor.
  """
  def advisor_fixture(attrs \\ %{}) do
    {:ok, advisor} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname"
      })
      |> Lissie.Staff.create_advisor()

    advisor
  end

  @doc """
  Generate a supervisor.
  """
  def supervisor_fixture(attrs \\ %{}) do
    {:ok, supervisor} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname",
        salutation: "some salutation"
      })
      |> Lissie.Staff.create_supervisor()

    supervisor
  end

  @doc """
  Generate a supervisor.
  """
  def supervisor_fixture(attrs \\ %{}) do
    {:ok, supervisor} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        salutation: "some salutation"
      })
      |> Lissie.Staff.create_supervisor()

    supervisor
  end
end
