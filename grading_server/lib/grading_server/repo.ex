defmodule GradingServer.Repo do
  use Ecto.Repo,
    otp_app: :grading_server,
    adapter: Ecto.Adapters.Postgres
end
