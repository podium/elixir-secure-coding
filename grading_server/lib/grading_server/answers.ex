defmodule GradingServer.Answers do
  @moduledoc """
  This module is responsible for checking if an answer is correct.
  It uses the `AnswerStore` to fetch the answer and compares if it is correct or not.
  """
  alias GradingServer.AnswerStore
  alias GradingServer.Answer

  @doc """
  Checks if the given answer is correct.
  """
  @spec is_correct(integer(), String.t()) :: true | %{help_text: String.t()}
  def is_correct(question_id, answer) do
    case AnswerStore.get_answer(question_id) do
      nil ->
        false

      %Answer{answer: correct_answer} ->
        String.trim(answer) == String.trim(correct_answer)
    end
  end
end
