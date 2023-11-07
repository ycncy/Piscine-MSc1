import Config

config :backend, Backend.Repo,
username: System.get_env("PGUSER"),
password: System.get_env("PGPASSWORD"),
hostname: System.get_env("PGHOST"),
port: System.get_env("PGPORT"),
database: "backend_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :backend, BackendWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "KdufjxNLIK2iKpP13NOKPDJSfa5ErdcpArsu3T/u/A5Dub1KQ/BcIAz9ZqtxayGy",
  server: false

config :backend, Backend.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
