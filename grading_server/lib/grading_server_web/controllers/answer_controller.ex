defmodule GradingServerWeb.AnswerController do
  use GradingServerWeb, :controller

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

  def check(conn, %{"module_id" => module_id} = payload) when is_binary(module_id) do
    case Integer.parse(module_id) do
      :error ->
        render(conn, "no_answer.json", module_id: module_id)

      {module_id, _} ->
        check(conn, %{payload | "module_id" => module_id})
    end
  end

  def check(conn, %{"question_id" => question_id, "answer" => answer, "module_id" => module_id}) do
    case Answers.check(module_id, question_id, answer) do
      :correct ->
        render(conn, "correct.json", question_id: question_id, module_id: module_id)

      {:incorrect, help_text} ->
        render(conn, "incorrect.json",
          question_id: question_id,
          module_id: module_id,
          help_text: help_text
        )
    end
  end
end
