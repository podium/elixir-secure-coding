import Config

config :grading_server, answer_store_file: "answers.yml"

# Configures the endpoint
config :grading_server, GradingServerWeb.Endpoint,
  server: false,
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
