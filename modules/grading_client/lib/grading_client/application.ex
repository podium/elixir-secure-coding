defmodule GradingClient.Application do
  use Application

  def start(_type, _args) do
    Kino.SmartCell.register(GradingClient.GradedCell)

    default_filename = Path.join(:code.priv_dir(:grading_client), "answers.exs")

    children = [
      {GradingClient.Answers,
       filename: Application.get_env(:grading_client, :answers_file, default_filename)}
    ]

    opts = [strategy: :one_for_one, name: GradingClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
