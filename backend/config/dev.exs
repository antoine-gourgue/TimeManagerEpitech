import Config

# Configure your database
config :time_manager, TimeManager.Repo,
       username: "postgres",
       password: "postgres",
       hostname: "db",
       database: "time_manager_dev",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

# Configure JWT secret
config :time_manager, :jwt_secret, "7c39900646686a9ca177b98e8bc77516dcb867e073b5a52730d80d21e983d6d7"

# Configure Joken
config :joken, default_signer: {Joken.Signer, algorithm: "HS256", key: Application.get_env(:time_manager, :jwt_secret)}

# For development, we disable any cache and enable
# debugging and code reloading.
config :time_manager, TimeManagerWeb.Endpoint,
       http: [ip: {0, 0, 0, 0}, port: 4000],
       check_origin: false,
       code_reloader: true,
       debug_errors: true,
       secret_key_base: "07YB1TiBsQQjMGEskqANQeNLqKh45dfSIyf/2kGxVonncq/ws0727e6CyePiBFoE",
       watchers: [
         esbuild: {Esbuild, :install_and_run, [:time_manager, ~w(--sourcemap=inline --watch)]},
         tailwind: {Tailwind, :install_and_run, [:time_manager, ~w(--watch)]}
       ]

# Watch static and templates for browser reloading.
config :time_manager, TimeManagerWeb.Endpoint,
       live_reload: [
         patterns: [
           ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
           ~r"priv/gettext/.*(po)$",
           ~r"lib/time_manager_web/(controllers|live|components)/.*(ex|heex)$"
         ]
       ]

# Enable dev routes for dashboard and mailbox
config :time_manager, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
       debug_heex_annotations: true,
       enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
