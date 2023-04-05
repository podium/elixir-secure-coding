defmodule GradingServer.KeyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GradingServer.Key` context.
  """

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        help_text: "some help_text",
        question_id: 42
      })
      |> GradingServer.Key.create_answer()

    answer
  end
end
