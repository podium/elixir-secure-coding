defmodule GradingServerWeb.AnswerController do
  use GradingServerWeb, :controller

  alias GradingServer.AnswerStore

  action_fallback(GradingServerWeb.FallbackController)

  def index(conn, _params) do
    render(conn, "index.json")
  end

  def show(conn, %{"id" => question_id}) do
    case Integer.parse(question_id) do
      :error ->
        render(conn, "no_answer.json", question_id: question_id)

      {question_id, _} ->
        case AnswerStore.get_answer(question_id) do
          nil ->
            render(conn, "no_answer.json", question_id: question_id)

          answer ->
            render(conn, "show.json", answer: answer)
        end
    end
  end
end
