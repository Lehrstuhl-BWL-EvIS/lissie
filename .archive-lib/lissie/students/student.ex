defmodule Lissie.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :student_id, :string
    field :firstname, :string
    field :lastname, :string
    field :dob, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:student_id, :firstname, :lastname, :dob])
    |> validate_required([:student_id, :firstname, :lastname])
    |> unique_constraint(:student_id)
    |> unique_constraint([:student_id, :firstname, :lastname])
    |> validate_length(:student_id, min: 4, max: 100)
    |> validate_length(:firstname, min: 2, max: 254)
    |> validate_length(:lastname, min: 2, max: 254)
  end
end
