defmodule GradingServerWeb.AnswerView do
  use GradingServerWeb, :view
  alias GradingServerWeb.AnswerView

  def render("index.json", %{answers: answers}) do
    %{data: render_many(answers, AnswerView, "answer.json")}
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
end
