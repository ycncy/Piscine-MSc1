defmodule BackendWeb.SessionUserController do
  use BackendWeb, :controller

  alias Comeonin.Bcrypt
  alias Backend.Users.User
  alias Backend.Repo
  alias Joken

  def login(conn, %{"username" => username, "password" => password}) do
    case User.authenticate(username, password) do
      {:ok, user} ->
        csrf_token = generate_csrf_token()

        jwt_payload = %{
          "user_id" => user.id,
          "role" => user.role,
          "csrf_token" => csrf_token,
          "exp" => DateTime.to_unix(DateTime.utc_now()) + 604800
        }

        jwt_token = Joken.sign(jwt_payload, BackendWeb.Endpoint.config(:joken_secret_key))

        conn
        |> put_resp_cookie("auth_token", jwt_token, http_only: true)
        |> json(%{message: "Login successful", user: user})

      {:error, reason} ->
        conn
        |> put_status(401)
        |> json(%{error: "Authentication failed", reason: reason})
    end
  end

  def register(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, %User{} = user} ->
        csrf_token = generate_csrf_token()

        jwt_payload = %{
          "user_id" => user.id,
          "role" => user.role,
          "csrf_token" => csrf_token,
          "exp" => DateTime.to_unix(DateTime.utc_now()) + 604800
        }

        jwt_token = Joken.sign(jwt_payload, BackendWeb.Endpoint.config(:joken_secret_key))

        conn
        |> put_resp_cookie("auth_token", jwt_token, http_only: true)
        |> json(%{message: "Signup and login successful", user: user})

      {:error, %Ecto.ConstraintError{message: error_message}} ->
        conn
        |> put_status(:forbidden)
        |> render(:error, %{error: "ConstraintError", message: error_message})
      _ ->
        send_resp(conn, 500, "Internal Server Error")
    end
  end

  defp generate_csrf_token() do
    {:ok, csrf_bytes} = :crypto.strong_rand_bytes(32)

    csrf_token = Base.encode16(csrf_bytes)

    csrf_token
  end

  defp authenticate(username, password) do
    case Repo.get_by(User, username: username) do
      nil ->
        {:error, "User not found"}

      user ->
        case check_password(user, password) do
          true ->
            {:ok, user}
          false ->
            {:error, "Invalid password"}
        end
    end
  end

  defp check_password(%User{password: stored_password}, given_password) do
    Comeonin.Bcrypt.checkpw(given_password, stored_password)
  end
end
