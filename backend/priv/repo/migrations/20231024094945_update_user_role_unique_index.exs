defmodule Backend.Repo.Migrations.UpdateUserRoleUniqueIndex do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, primary_key: true
      add :email, :string, null: false, primary_key: true
      add :role, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, :username)
    create unique_index(:users, :email)
  end
end
