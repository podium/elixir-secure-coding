import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :grading_server, GradingServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "d//8uGEq9XnUKtzlFN5q5ia38hfd3HI38K6wWjXBEDsIJCaZMTPfX0z3biIX2qVQ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
