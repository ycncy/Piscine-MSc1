defmodule Backend.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :userId, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:clocks, [:userId])
  end
end
