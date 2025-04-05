defmodule GradingClient.Answers do
  @moduledoc """
  This module is responsible for checking if an answer is correct.
  It uses the `AnswerStore` to fetch the answer and compares if it is correct or not.
  """
  use GenServer

  alias GradingClient.Answer

  @table :answer_store

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    :ets.new(@table, [:set, :named_table])

    filename = opts[:filename]

    {answers, _} = Code.eval_file(filename)

    modules =
      MapSet.new(answers, fn answer ->
        :ets.insert(@table, {{answer.module_id, answer.question_id}, answer})
        answer.module_id
      end)

    {:ok, %{modules: modules}}
  end

  @doc """
  Checks if the given answer is correct.
  """
  @spec check(integer(), integer(), String.t()) :: :correct | {:incorrect, String.t()}
  def check(module_id, question_id, answer) do
    GenServer.call(__MODULE__, {:check, module_id, question_id, answer})
  end

  @doc """
  Returns the list of modules.
  """
  @spec get_modules() :: [atom()]
  def get_modules() do
    GenServer.call(__MODULE__, :get_modules)
  end

  @impl true
  def handle_call(:get_modules, _from, state) do
    {:reply, state.modules, state}
  end

  @impl true
  def handle_call({:check, module_id, question_id, answer}, _from, state) do
    result =
      case :ets.lookup(@table, {module_id, question_id}) do
        [] ->
          {:incorrect, "Question not found"}

        [{_id, %Answer{answer: correct_answer, help_text: help_text}}] ->
          dbg(answer)
          dbg(correct_answer)

          if answer == correct_answer do
            :correct
          else
            {:incorrect, help_text}
          end
      end

    {:reply, result, state}
  end
end
