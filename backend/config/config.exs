# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :backend,
       ecto_repos: [Backend.Repo],
       generators: [timestamp_type: :utc_datetime]

config :backend, BackendWeb.CSRFProtectionPlug,
       csrf: true,
       csrf_salt: "eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTY5OTAwODQ5MiwiaWF0IjoxNjk5MDA4NDkyfQ.8aU1PEXs578iH2uP9bTCwRnaNSAj9pkl4cndXf_4LII"

# Configures the endpoint
config :backend, BackendWeb.Endpoint,
       cors: [
         origins: ["http://localhost:8080", "http://34.155.108.18:8080"],
         credentials: true
       ],
       url: [host: "localhost"],
       adapter: Phoenix.Endpoint.Cowboy2Adapter,
       render_errors: [
         formats: [json: BackendWeb.ErrorJSON],
         layout: false
       ],
       pubsub_server: Backend.PubSub,
       live_view: [signing_salt: "+cjHlRIv"],
       joken_secret_key: "eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6Ik1vaSIsImV4cCI6MTY5OTAwNTU3OCwiaWF0IjoxNjk5MDA1NTc4fQ.pg2iRMTW7mEF0dlaEERph26qIFvfUCW9mz98H3P3GIQ"

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :backend, Backend.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
       version: "0.17.11",
       default: [
         args:
           ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
         cd: Path.expand("../assets", __DIR__),
         env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
       ]

# Configure tailwind (the version is required)
config :tailwind,
       version: "3.3.2",
       default: [
         args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
         cd: Path.expand("../assets", __DIR__)
       ]

# Configures Elixir's Logger
config :logger, :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"