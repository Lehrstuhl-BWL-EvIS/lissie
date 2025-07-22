defmodule Lissie.Repo.Migrations.AddDobToStudents do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :dob, :date
    end
  end
end
