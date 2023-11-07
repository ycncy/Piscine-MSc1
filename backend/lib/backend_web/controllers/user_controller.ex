defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Users
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def get_all(conn, _params) do
    users = Users.list_users()
    conn
    |> put_status(200)
    |> json(users)
  end

  def delete_all_users(conn, _params) do
    Repo.delete_all(User)
    conn
    |> put_status(200)
    |> json(%{message: "Tous les utilisateurs ont été supprimés"})
  end

  def get_user_by_id(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
          user ->
            conn
            |> put_status(200)
            |> json(user)
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def get_user_by_credentials(conn, _params) do
    user_params = conn.query_params
    username = Map.get(user_params, "username")
    email = Map.get(user_params, "email")

    if(username==nil || email == nil)do
      send_resp(conn,400,Poison.encode!(%{error: "Bad arguments", message: "Argument email or username unspecified"}))
    else
      case Repo.get_by(User, username: username, email: email) do
        nil ->
          conn
          |> put_status(404)
          |> json(%{error: "NoResultError", message: "No user found for credentials"})
        user ->
          conn
          |> put_status(200)
          |> json(user)
      end
    end
  end

  def create_user(conn, %{"user" => user_params}) do
    user_params = Map.update!(user_params, "password", &Comeonin.Bcrypt.hashpwsalt/1)

    username = Map.get(user_params,"username");
    email = Map.get(user_params,"email")
    password = Map.get(user_params, "password")
    role = Map.get(user_params,"role")

    if (username == "" || email == "" || password == "" || (role != "employee" && role != "manager" && role != "general_manager" && role != "administrator") ) do
      conn
      |> put_status(422)
      |> json(%{error: "invalid data"})

    else
      case Users.create_user(user_params) do
        {:ok, %User{} = user} ->
          conn
          |> put_status(201)
          |> json(user)

        {:error, %Ecto.ConstraintError{message: error_message}} ->
          conn
          |> put_status(403)
          |> json(%{error: "ConstraintError", message: error_message})
        _ ->
          conn
          |> put_status(500)
          |> json(%{error: "InternalServerError", message: "Internal Server Error"})
      end
    end
  end

  def update_user(conn, %{"userID" => user_id, "user" => user_params}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Users.get_user!(user_id_int) do
          %User{} = user ->
            user_params = Map.update!(user_params, "password", &Comeonin.Bcrypt.hashpwsalt/1)
            case Users.update_user(user, user_params) do
              {:ok, %User{} = updated_user} ->
                conn
                |> put_status(200)
                |> json(updated_user)

              {:error, _} ->
                conn
                |> put_status(400)
                |> json(%{error: "UpdateError", message: "Failed to update the user"})
            end

          :error ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
        end

      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def delete_user(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Users.get_user!(user_id_int) do
          %User{} = user ->
            case Users.delete_user(user) do
              {:ok, %User{} = deleted_user} ->
                conn
                |> put_status(204)
                |> json(deleted_user)

              {:error, _} ->
                conn
                |> put_status(500)
                |> json(%{error: "DeleteError", message: "Failed to delete the user"})
            end

          :error ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
        end

      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end
end
