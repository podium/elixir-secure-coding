# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :grading_server,
  answer_store_file: "answers.yml",
  ecto_repos: []

# Configures the endpoint
config :grading_server, GradingServerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: GradingServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GradingServer.PubSub,
  live_view: [signing_salt: "HVVkYc2t"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :simple_token_authentication,
  # CHANGE ME IF IN USE
  token: "my-token"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
