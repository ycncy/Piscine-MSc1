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

  def get_user_by_id(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "UserNotFound", message: "User not found"}))
          user ->
            render(conn, :show, user: user)
        end
      :error ->
        send_resp(conn, 400, %{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def get_user_by_credentials(conn, _params) do
    user_params = conn.query_params
    username = Map.get(user_params, "username")
    email = Map.get(user_params, "email")

    case Repo.get_by(User, username: username, email: email) do
      nil ->
        send_resp(conn, 404, Poison.encode!(%{error: "NoResultError", message: "No user found for credentials"}))
      user ->
        render(conn, :show, user: user)
    end
  end

  def create_user(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> render(:show, user: user)

      {:error, %Ecto.ConstraintError{message: error_message}} ->
        conn
        |> put_status(:forbidden)
        |> render(:error, %{error: "ConstraintError", message: error_message})
      _ ->
        send_resp(conn, 500, "Internal Server Error")
    end
  end

  def update_user(conn, %{"userID" => user_id, "user" => user_params}) do
    try do
      user = Users.get_user!(user_id)

      with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
        render(conn, :show, user: user)
      end
    rescue
      FunctionClauseError -> send_resp(conn, 404, Poison.encode(%{error: "NoResultError", message: "User #{user_id} not found"}))
    end
  end

  def delete_user(conn, %{"userID" => user_id}) do
    try do
      user = Users.get_user!(user_id)

      with {:ok, %User{}} <- Users.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, Poison.encode(%{error: "NoResultError", message: "User #{user_id} not found"}))
    end
  end
end
