defmodule Lissie.Repo.Migrations.CreateAdvisors do
  use Ecto.Migration

  def change do
    create table(:advisors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :firstname, :citext, null: false
      add :lastname, :citext, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:advisors, [:lastname])

    create(unique_index(:advisors, [:firstname, :lastname]))
  end
end
