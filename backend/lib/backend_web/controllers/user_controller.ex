defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def get_all(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create_user(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def get_user_by_id(conn, %{"userID" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def get_user_by_id(conn, %{"user" => user_params}) do
    username = Map.get(user_params, "username")
    email = Map.get(user_params, "email")

    user = Users.get_user!(%User{username: username, email: email})
    render(conn, :show, user: user)
  end

  def update_user(conn, %{"userID" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete_user(conn, %{"userID" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
