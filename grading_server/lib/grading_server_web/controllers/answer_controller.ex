defmodule GradingServerWeb.AnswerController do
  use GradingServerWeb, :controller

  alias GradingServer.Key

  action_fallback GradingServerWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json")
  end

  def show(conn, %{"id" => id}) do
    case Integer.parse(id) do
      :error ->
        render(conn, "no_answer.json", question_id: id)
      {question_id, _} ->
        case Key.get_answer(question_id) do
          nil ->
            render(conn, "no_answer.json", question_id: id)
          answer ->
            render(conn, "show.json", answer: answer)
        end
    end
  end

end
