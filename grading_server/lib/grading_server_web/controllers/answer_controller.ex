defmodule GradingServerWeb.AnswerController do
  use GradingServerWeb, :controller

  alias GradingServer.AnswerStore
  alias GradingServer.Answers

  action_fallback(GradingServerWeb.FallbackController)

  def index(conn, _params) do
    render(conn, "index.json")
  end

  def check(conn, %{"question_id" => question_id} = payload) when is_binary(question_id) do
    case Integer.parse(question_id) do
      :error ->
        render(conn, "no_answer.json", question_id: question_id)

      {question_id, _} ->
        check(conn, %{payload | "question_id" => question_id})
    end
  end

  def check(conn, %{"question_id" => question_id, "answer" => answer}) do
    case Answers.check(question_id, answer) do
      :correct ->
        render(conn, "correct.json", question_id: question_id)

      {:incorrect, help_text} ->
        render(conn, "incorrect.json", question_id: question_id, help_text: help_text)
    end
  end
end
