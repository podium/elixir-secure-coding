defmodule GradingClient do
  @moduledoc """
  Module used for checking answers to questions.
  """

  @doc """
  Checks the answer to a question.
  """

  @spec check_answer(any() | String.t(), integer(), integer()) :: :ok | {:error, String.t()}
  def check_answer(answer, module_id, question_id) when not is_binary(answer) do
    check_answer(module_id, question_id, "#{inspect(answer)}")
  end

  def check_answer(answer, module_id, question_id) do
    # TODO: Make this configurable
    url = "http://localhost:4000/api/answers/check"

    headers = [
      {"Content-Type", "application/json"}
    ]

    json = Jason.encode!(%{module_id: module_id, question_id: question_id, answer: answer})

    %{body: body, status_code: 200} = HTTPoison.post!(url, json, headers)

    %{"correct" => is_correct, "help_text" => help_text} = Jason.decode!(body)

    if is_correct do
      :ok
    else
      {:error, help_text}
    end
  end
end
