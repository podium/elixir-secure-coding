defmodule GradingServerWeb.DefaultController do
  use GradingServerWeb, :controller

  def index(conn, _params) do
    text conn, "This is the ESCT Grading Server hosted by Podium, be nice!"
  end
end
