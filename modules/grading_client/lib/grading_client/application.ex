defmodule GradingClient.Application do
  use Application

  def start(_type, _args) do
    Kino.SmartCell.register(GradingClient.GradingCell)

    children = []

    opts = [strategy: :one_for_one, name: GradingClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
