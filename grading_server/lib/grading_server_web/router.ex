defmodule GradingServerWeb.Router do
  use GradingServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GradingServerWeb do
    pipe_through :api
    resources "/answers", AnswerController, except: [:new, :edit]
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", GradingServerWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

  # Enables LiveDashboard only for development
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: GradingServerWeb.Telemetry
    end
  end
end
