defmodule Lissie.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :student_id, :citext, null: false
      add :firstname, :citext, null: false
      add :lastname, :citext, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:students, [:lastname])

    create unique_index(:students, [:student_id])
    create(unique_index(:students, [:student_id, :firstname, :lastname]))
  end
end
