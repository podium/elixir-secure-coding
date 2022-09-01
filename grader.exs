# Usage: mix run grader.exs

defmodule Grader.Client do
  use GenServer

  alias Livebook.{Session, LiveMarkdown}

  def run_and_save(notebook_path) do
    {:ok, pid} = GenServer.start(__MODULE__, {notebook_path})

    ref = Process.monitor(pid)

    receive do
      {:DOWN, ^ref, :process, _pid, _reason} -> :ok
    end
  end

  @impl true
  def init({notebook_path}) do
    IO.puts("Evaluating: #{notebook_path}")
    {notebook, _messages} =
      notebook_path
      |> File.read!()
      |> LiveMarkdown.notebook_from_livemd()

      {:ok, session} = Livebook.Sessions.create_session(notebook: notebook)

    {data, _client_id} = Session.register_client(session.pid, self(), Livebook.Users.User.new())

    Session.subscribe(session.id)
    Session.queue_full_evaluation(session.pid, [])

    {:ok, %{notebook_path: notebook_path, session: session, data: data, evaluated_count: 0}}
  end

  @impl true
  def handle_info({:operation, operation}, state) do
    data =
      case Session.Data.apply_operation(state.data, operation) do
        {:ok, data, _actions} -> data
        :error -> state.data
      end

    {evaluated_count, evaluable_count} = evaluation_progress(data)

    if evaluated_count != state.evaluated_count do
      IO.puts("Evaluated cell: #{evaluated_count}/#{evaluable_count}")
    end

    if evaluated_count == evaluable_count do
      content = LiveMarkdown.notebook_to_livemd(data.notebook, include_outputs: true)
      File.write!(state.notebook_path, content)
      {:stop, :shutdown, state}
    else
      {:noreply, %{state | data: data, evaluated_count: evaluated_count}}
    end
  end

  def handle_info(_message, state), do: {:noreply, state}

  defp evaluation_progress(data) do
    evaluable = Livebook.Notebook.evaluable_cells_with_section(data.notebook)

    evaluated_count =
      Enum.count(evaluable, fn {cell, _} ->
        match?(%{validity: :evaluated, status: :ready}, data.cell_infos[cell.id].eval)
      end)

    {evaluated_count, length(evaluable)}
  end
end

defmodule Grader.App do
  def main() do
    Path.wildcard("./modules/*.livemd")
    |> Enum.each(fn module -> Grader.Client.run_and_save(module) end)

    IO.puts("Saved module outputs")
  end
end

Grader.App.main()
