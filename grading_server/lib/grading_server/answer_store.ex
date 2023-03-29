defmodule GradingServer.AnswerStore do
  @moduledoc """
  This is a representatino of the `priv/answers.yml` file. It utilizes a write back caching mechanism.
  """

  use GenServer

  alias GradingServer.Answer

  @table :answer_store

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(state) do
    :ets.new(@table, [:set, :named_table])

    Enum.each(load_answers(), fn answer ->
      :ets.insert(@table, {key(answer.module_id, answer.question_id), answer})
    end)

    {:ok, state}
  end

  defp key(module_id, question_id), do: "module_#{module_id}-#{question_id}}"

  @impl true
  def handle_call({:fetch, module_id, question_id}, _from, _) do
    item = :ets.lookup(@table, key(module_id, question_id))

    item =
      if Enum.empty?(item) do
        nil
      else
        [{_id, item}] = item
        item
      end

    {:reply, item, nil}
  end

  @doc """
  Fetches the given answer from the store.
  """
  def get_answer(module_id, question_id) do
    GenServer.call(__MODULE__, {:fetch, module_id, question_id})
  end

  # load a file from the priv folder
  defp load_answers() do
    file = Application.fetch_env!(:grading_server, :answer_store_file)
    file = Path.join([:code.priv_dir(:grading_server), file])

    {:ok, modules} = YamlElixir.read_from_file(file)

    modules
    |> Enum.map(&map_module/1)
    |> List.flatten()
  end

  defp map_module({module_name, answers}) do
    [_, module_id] = String.split(module_name, "module_")
    module_id = String.to_integer(module_id)

    Enum.map(answers, fn data ->
      %Answer{
        module_id: module_id,
        answer: data["answer"],
        help_text: data["help_text"],
        question_id: data["question_id"]
      }
    end)
  end
end
