defmodule Backend.Repo.Migrations.UpdateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :role, :enum, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
