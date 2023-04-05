defmodule GradingServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GradingServerWeb.Telemetry,
      GradingServer.AnswerStore,
      # Start the PubSub system
      {Phoenix.PubSub, name: GradingServer.PubSub},
      # Start the Endpoint (http/https)
      GradingServerWeb.Endpoint
      # Start a worker by calling: GradingServer.Worker.start_link(arg)
      # {GradingServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GradingServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GradingServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
