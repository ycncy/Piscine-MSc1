defmodule Backend.Repo.Migrations.AllTables do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string, null: false
    end

    create unique_index(:teams, :id)

    execute("INSERT INTO teams (name) VALUES ('admin')")

    create table(:users) do
      add :username, :string, null: false, primary_key: true
      add :email, :string, null: false, primary_key: true
      add :role, :string, null: false
      add :password, :string, null: false
      add :team_id, references(:teams, column: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :id)
    create unique_index(:users, :username)
    create unique_index(:users, :email)

    create table(:working_times) do
      add :start_time, :naive_datetime, null: false
      add :end_time, :naive_datetime, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:working_times, [:user_id])

    create table(:clocks) do
      add :time, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, column: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

  end
end
