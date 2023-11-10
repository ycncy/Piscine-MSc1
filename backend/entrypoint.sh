mix archive.install hex phx_new
mix deps.get
mix ecto.create
mix ecto.migrate
exec mix phx.server