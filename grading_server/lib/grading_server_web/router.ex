defmodule GradingServerWeb.Router do
  use GradingServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    # plug SimpleTokenAuthentication
  end

  scope "/api", GradingServerWeb do
    pipe_through(:api)
    get("/", DefaultController, :index)
    post("/answers", AnswerController, :check)
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'"})
  end

  scope "/", GradingServerWeb do
    pipe_through(:browser)
    get("/", DefaultController, :index)
  end

  # Enables LiveDashboard only for development
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: GradingServerWeb.Telemetry)
    end
  end
end
