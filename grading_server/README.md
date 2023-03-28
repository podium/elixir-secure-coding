# ESCT - Grading Server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Deploying your own version

This only applies if you've created your own Grading Server and wish to lock down the API to your internal users.

1. Uncomment the `plug SimpleTokenAuthentication` line in the `router.ex` file
2. Change the value of the config for `:simple_token_authentication` in `config/config.exs`
