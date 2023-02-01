defmodule GradingServerWeb.AnswerControllerTest do
  use GradingServerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all answers", %{conn: conn} do
      conn = get(conn, Routes.answer_path(conn, :index))
      assert json_response(conn, 200) == %{"errors" => %{"detail" => "Nice try, you didn't think it would be that easy to get all the answers - did you?"}}
    end
  end
end
