defmodule GradingServer.AnswerStore do
  @moduledoc """
  This is a representatino of the `priv/${ENV}_answers.yml` file. It utilizes a write back caching mechanism.
  """

  use GenServer

  @table :answer_store

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(state) do
    :ets.new(@table, [:set, :named_table])

    {:ok, state}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call({:fetch, id}, _from, _) do
    item = :ets.lookup(@table, id)

    item =
      if Enum.empty?(item) do
        answer = "TODO: Need to fetch from YAML file + store"
        cache(id, answer)
      else
        [{_id, item}] = item
        item
      end

    {:reply, item, nil}
  end

  @impl true
  def handle_call({:cache, value}, _, _) do
    {:reply, :ets.insert(@table, value), nil}
  end

  @doc """
  Fetches the given answer from the store.
  """
  def fetch(id) do
    GenServer.call(__MODULE__, {:fetch, id})
  end

  @doc """
  Caches the given answer.
  """
  def cache(id, answer) do
    GenServer.call(__MODULE__, {:cache, {id, answer}})
  end
end
