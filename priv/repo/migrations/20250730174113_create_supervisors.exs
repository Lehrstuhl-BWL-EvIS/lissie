defmodule Lissie.Repo.Migrations.CreateSupervisors do
  use Ecto.Migration

  def change do
    create table(:supervisors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :salutation, :citext
      add :firstname, :citext, null: false
      add :lastname, :citext, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:supervisors, [:lastname])

    create unique_index(:supervisors, [:email])
    create(unique_index(:supervisors, [:firstname, :lastname]))
  end
end
