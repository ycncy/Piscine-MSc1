defmodule BackendWeb.ManagerPlug do
  import Plug.Conn
  alias Joken

  def init(opts), do: opts

  def call(conn, _opts) do
    case Map.get(conn.req_cookies, "auth_token") do
      nil ->
        conn
        |> put_status(403)
        |> send_resp(:forbidden, "Forbidden")
        |> halt()
      auth_token ->
        case JWT.verify!(auth_token, %{key: BackendWeb.Endpoint.config(:joken_secret_key)}) do
          claims ->
            case Map.get(claims, "role") do
              "manager" ->
                conn
              "general_manager" ->
                conn
              "administrator" ->
                conn
              _ ->
                conn
                |> put_status(403)
                |> send_resp(:forbidden, "Forbidden")
                |> halt()
            end
          :error ->
            conn
            |> put_status(403)
            |> send_resp(:forbidden, "Forbidden")
            |> halt()
        end
    end
  end


end
