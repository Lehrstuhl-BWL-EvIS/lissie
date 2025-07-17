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
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs, user_scope) do
    student
    |> cast(attrs, [:student_id, :firstname, :lastname, :dob])
    |> validate_required([:student_id, :firstname, :lastname, :dob])
    |> unique_constraint(:student_id)
    |> put_change(:user_id, user_scope.user.id)
  end
end
