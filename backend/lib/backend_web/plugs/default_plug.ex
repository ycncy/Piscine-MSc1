defmodule BackendWeb.DefaultPlug do
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
          :error ->
            conn
            |> put_status(403)
            |> send_resp(:forbidden, "Forbidden")
            |> halt()
          _ ->
            conn
        end
    end
  end


end
