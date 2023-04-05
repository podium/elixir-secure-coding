defmodule GradingServerWeb.DefaultController do
  use GradingServerWeb, :controller

  def index(conn, _params) do
    text conn, "This is the Elixir Secure Coding Training - Grading Server hosted by Podium for free, so be nice!"
  end
end
