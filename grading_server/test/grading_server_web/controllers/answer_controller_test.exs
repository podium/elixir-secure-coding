defmodule GradingServerWeb.AnswerControllerTest do
  use GradingServerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
  end
end
