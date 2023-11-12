defmodule Backend.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@mail.com",
        username: "someusername",
        password: "somepassword",
        team_id: 1,
        role: "employee"
      })
      |> Backend.Users.create_user()

    user
  end
  def admin_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "administrator@timemanager.com",
        username: "administrator",
        password: Comeonin.Bcrypt.hashpwsalt("administrator"),
        team_id: 1,
        role: "administrator"
      })
      |> Backend.Users.create_user()

    user
  end
end
