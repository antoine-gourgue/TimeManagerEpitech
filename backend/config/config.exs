# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

import Config

config :time_manager,
       ecto_repos: [TimeManager.Repo],
       generators: [timestamp_type: :utc_datetime]

config :time_manager, TimeManagerWeb.Endpoint,
       url: [host: "localhost"],
       adapter: Bandit.PhoenixAdapter,
       render_errors: [
         formats: [html: TimeManagerWeb.ErrorHTML, json: TimeManagerWeb.ErrorJSON],
         layout: false
       ],
       pubsub_server: TimeManager.PubSub,
       live_view: [signing_salt: "eIAI9F/0"]

config :time_manager, TimeManager.Mailer, adapter: Swoosh.Adapters.Local

# Configure JWT secret
config :time_manager, :jwt_secret, "7c39900646686a9ca177b98e8bc77516dcb867e073b5a52730d80d21e983d6d7"

# Configure Joken
config :joken, default_signer: {Joken.Signer, algorithm: "HS256", key: "7c39900646686a9ca177b98e8bc77516dcb867e073b5a52730d80d21e983d6d7"}

# Configure esbuild (the version is required)
config :esbuild,
       version: "0.17.11",
       time_manager: [
         args:
           ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
         cd: Path.expand("../assets", __DIR__),
         env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
       ]

# Configure tailwind (the version is required)
config :tailwind,
       version: "3.4.3",
       time_manager: [
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
