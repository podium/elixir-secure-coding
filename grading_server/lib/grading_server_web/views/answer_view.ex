defmodule GradingServerWeb.AnswerView do
  use GradingServerWeb, :view
  alias GradingServerWeb.AnswerView

  def render("index.json", _assigns) do
    %{
      errors: %{
        detail:
          "Nice try, you didn't think it would be that easy to get all the answers - did you?"
      }
    }
  end

  def render("correct.json", %{question_id: question_id}) do
    %{question_id: question_id, correct: true, help_text: nil}
  end

  def render("incorrect.json", %{question_id: question_id, help_text: help_text}) do
    %{question_id: question_id, correct: false, help_text: help_text}
  end
end
