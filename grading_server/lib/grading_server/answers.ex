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
  @spec check(integer(), String.t()) :: :correct | {:incorrect, String.t()}
  def check(question_id, answer) do
    case AnswerStore.get_answer(question_id) do
      nil ->
        {:incorrect, "Question not found"}

      %{answer: correct_answer, help_text: help_text} ->
        if String.trim(answer) == String.trim(correct_answer) do
          :correct
        else
          {:incorrect, help_text}
        end
    end
  end
end
