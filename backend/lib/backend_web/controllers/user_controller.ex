defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Users
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def get_all(conn, _params) do
    users = Users.list_users()

    render(conn, :index, users: users)
  end

  def create_user(conn, %{"user" => user_params}) do
    try do
      with {:ok, %User{} = user} <- Users.create_user(user_params) do
        conn
        |> put_status(:created)
        |> render(:show, user: user)
      end
    rescue
      Ecto.ConstraintError -> send_resp(conn, 403, Poison.encode!(%{error: "ConstraintError", message: "User already exists"}))
    end
  end

  def get_user_by_id(conn, %{"userID" => id}) do
    try do
      user = Users.get_user!(id)

      render(conn, :show, user: user)
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, "No user found for user_id : #{id}")
    end
  end

  def get_user_by_credentials(conn, _params) do
    user_params = conn.query_params

    username = Map.get(user_params, "username")
    email = Map.get(user_params, "email")

    try do
      user = Repo.get_by!(User, username: username, email: email)
      render(conn, :show, user: user)
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, Poison.encode(%{error: "Not found", message: "No user found for credentials"}))
    end
  end

  def update_user(conn, %{"userID" => id, "user" => user_params}) do
    try do
      user = Users.get_user!(id)

      with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
        render(conn, :show, user: user)
      end
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, "No user found for user_id : #{id}")
    end
  end

  def delete_user(conn, %{"userID" => id}) do
    try do
      user = Users.get_user!(id)

      with {:ok, %User{}} <- Users.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, "No user found for user_id : #{id}")
    end
  end
end
