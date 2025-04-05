defmodule GradingClient do
  @moduledoc """
  Module used for checking answers to questions.
  """

  @doc """
  Checks the answer to a question.
  """

  @spec check_answer(any(), any(), any()) :: :correct | {:incorrect, String.t() | nil}
  def check_answer(answer, module_id, question_id) do
    GradingClient.Answers.check(module_id, question_id, answer)
  end
end
