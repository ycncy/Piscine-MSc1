defmodule BackendWeb.CorsMiddleware do
    import Plug.Conn

    def init(_opts), do: nil

    def call(conn, _opts) do
      conn
      |> put_resp_header("access-control-allow-origin", "http://34.155.108.18:8080")
      |> put_resp_header("access-control-allow-methods", "GET, POST, PUT, DELETE")
      |> put_resp_header("access-control-allow-headers", "authorization")
      |> put_resp_header("access-control-max-age", "3600")
    end
end
