defmodule GradingClient.GradedCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Graded Cell"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""

    {:ok, assign(ctx, source: source), editor: [source: source, language: "elixir"]}
  end

  @impl true
  def handle_editor_change(source, ctx) do
    {:ok, assign(ctx, source: source)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"source" => ctx.assigns.source}
  end

  @impl true
  def to_source(attrs) do
    modules = Map.new(GradingClient.Answers.get_modules(), &{inspect(&1), &1})

    source_ast =
      try do
        source_attr = attrs["source"]
        source = Code.string_to_quoted!(source_attr)

        [module_id, question_id] =
          String.split(source_attr, "\n", parts: 2)
          |> hd()
          |> String.trim_leading("#")
          |> String.split(":", parts: 2)

        module_id =
          case modules[String.trim(module_id)] do
            nil ->
              raise "invalid module id: #{module_id}"

            module_id ->
              module_id
          end

        question_id =
          case Integer.parse(String.trim(question_id)) do
            {id, ""} ->
              id

            _ ->
              raise "invalid question id: #{question_id}"
          end

        quote do
          result = unquote(source)

          case GradingClient.check_answer(unquote(module_id), unquote(question_id), result) do
            :correct ->
              IO.puts([IO.ANSI.green(), "Correct!", IO.ANSI.reset()])

            {:incorrect, help_text} when is_binary(help_text) ->
              IO.puts([IO.ANSI.red(), "Incorrect: ", IO.ANSI.reset(), help_text])

            _ ->
              IO.puts([IO.ANSI.red(), "Incorrect.", IO.ANSI.reset()])
          end
        end
      rescue
        error ->
          IO.inspect(error)
          source_attr = attrs["source"]
          {:ok, ast} = Code.Fragment.container_cursor_to_quoted(source_attr)

          case ast do
            {:__block__, meta, args} ->
              {
                :__block__,
                meta,
                Enum.reject(args, fn node ->
                  match?({:__cursor__, _, _}, node)
                end) ++
                  [:ok]
              }

            _ ->
              ast
          end
      end

    Kino.SmartCell.quoted_to_string(source_ast)
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      root.innerHTML = `
        <div class="app">
          <div class="text-lg font-bold">Graded Cell</div>
        </div>
      `;
    }
    """
  end

  asset "main.css" do
    """
    .app {
      padding: 8px 16px;
      border: solid 1px #cad5e0;
      border-radius: 0.5rem 0.5rem 0 0;
      border-bottom: none;
    }
    """
  end
end
