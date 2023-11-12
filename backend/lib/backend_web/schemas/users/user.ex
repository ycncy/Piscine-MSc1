defmodule Backend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email, :team_id, :role]}
  schema "users" do
    field :username, :string
    field :email, :string
    field :role, Ecto.Enum, values: [:employee, :manager, :general_manager, :administrator]
    field :password, :string
    field :team_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :team_id, :password])
    |> validate_required([:username, :email, :role, :team_id, :password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Not valid email format")
  end
end
