defmodule GradingServerWeb.AnswerView do
  use GradingServerWeb, :view
  alias GradingServerWeb.AnswerView

  def render("index.json", _assigns) do
    %{errors: %{detail: "Nice try, you didn't think it would be that easy to get all the answers - did you?"}}
  end

  def render("show.json", %{answer: answer}) do
    %{data: render_one(answer, AnswerView, "answer.json")}
  end

  def render("answer.json", %{answer: answer}) do
    %{
      id: answer.id,
      question_id: answer.question_id,
      answer: answer.answer,
      help_text: answer.help_text
    }
  end

  def render("no_answer.json", %{question_id: question_id}) do
    %{errors: %{detail: "Sorry, no answer was found for Question ID: #{question_id}"}}
  end
end
