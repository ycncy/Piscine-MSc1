defmodule BackendWeb.SessionUserController do
  use BackendWeb, :controller

  alias Comeonin.Bcrypt
  alias Backend.Users.User
  alias Backend.Users
  alias Backend.Repo
  alias Joken

  def login(conn, %{"user" => user_params}) do
    email = Map.get(user_params, "email")
    password = Map.get(user_params, "password")

    case authenticate(email, password) do
      {:ok, user} ->
        csrf_token = generate_csrf_token()

        IO.inspect(csrf_token)

        jwt_payload = %{
          "user_id" => user.id,
          "role" => user.role,
          "csrf_token" => csrf_token,
          "exp" => DateTime.to_unix(DateTime.utc_now()) + 604800
        }

        jwt_token = JWT.sign(jwt_payload, %{key: BackendWeb.Endpoint.config(:joken_secret_key)})

        conn
        |> put_resp_cookie("auth_token", jwt_token, http_only: true)
        |> json(%{message: "Login successful", user: %{id: user.id, role: user.role}, csrf_token: csrf_token})

      {:error, reason} ->
        conn
        |> put_status(400)
        |> json(%{error: "Login failed", reason: reason})
    end
  end

  def logout(conn, _params) do
    csrf_token = Plug.Conn.get_req_header(conn, "csrf-token")
    IO.inspect(Plug.Conn.get_req_header(conn, "csrf-token"))
    case csrf_token do
      _ ->

        case Map.get(conn.req_cookies, "auth_token") do
          auth_token ->
            case JWT.verify!(auth_token, %{key: BackendWeb.Endpoint.config(:joken_secret_key)}) do
              claims ->
                conn
                |> delete_resp_cookie("auth_token")
                |> put_status(200)
                |> json(%{message: "Logout successful"})
              {:error, reason} ->
                conn
                |> put_status(400)
                |> json(%{error: "Bad request : jwt token not found"})
            end
          {:error, reason} ->
            conn
            |> put_status(400)
            |> json(%{error: "Bad request : jwt token not found"})
        end
      [] ->
        conn
        |> put_status(400)
        |> json(%{error: "Bad request : csrf header not found"})
      {:error, reason} ->
        conn
        |> put_status(500)
        |> json(%{error: "Logout failed", reason: reason})
    end

  end

  defp authenticate(email, password) do
    case Repo.get_by(User, email: email) do
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

  def generate_csrf_token do
    :crypto.strong_rand_bytes(32) |> Base.encode16()
  end
end
