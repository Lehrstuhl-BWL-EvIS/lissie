defmodule Lissie.Staff.Supervisor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "supervisors" do
    field :email, :string
    field :salutation, :string
    field :firstname, :string
    field :lastname, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(supervisor, attrs) do
    supervisor
    |> cast(attrs, [:email, :salutation, :firstname, :lastname])
    |> validate_required([:email, :firstname, :lastname])
    |> validate_format(:email, ~r/^[^@,;\s]+@[^@,;\s]+$/,
      message: "must have the @ sign and no spaces"
    )
    |> validate_length(:email, max: 160)
    |> validate_length(:salutation, min: 2, max: 254)
    |> validate_length(:firstname, min: 2, max: 254)
    |> validate_length(:lastname, min: 2, max: 254)
  end
end
