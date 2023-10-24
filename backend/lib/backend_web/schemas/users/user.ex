defmodule Backend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :role, Ecto.Enum, values: [:employee, :manager, :general_manager]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email, :role])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Not valid email format")
  end
end
