defmodule GradingClient.GradedCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Graded Cell"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""

    {:ok, assign(ctx, source: source, module_id: nil, question_id: nil),
     editor: [source: source, language: "elixir"]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  @impl true
  def handle_editor_change(source, ctx) do
    {:ok, assign(ctx, source: source)}
  end

  @impl true
  def to_attrs(ctx) do
    %{
      "source" => ctx.assigns.source,
      "module_id" => ctx.assigns.module_id,
      "question_id" => ctx.assigns.question_id
    }
  end

  @impl true
  def to_source(attrs) do
    dbg(attrs)

    options = Enum.map(GradingClient.Answers.get_modules(), &{&1, inspect(&1)})

    inputs =
      quote do
        module_id = Kino.Input.select("Module", unquote(options))
        question_id = Kino.Input.number("Question ID")

        Kino.render(Kino.Layout.grid([module_id, question_id], columns: 2))
        nil
      end

    source_ast =
      try do
        source = Code.string_to_quoted!(attrs["source"])

        quote do
          module_id = Kino.Input.read(module_id)
          question_id = Kino.Input.read(question_id)

          result = unquote(source)

          case GradingClient.check_answer(module_id, question_id, result) do
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
          {:<<>>, [delimiter: ~s["""]], [attrs["source"] <> "\n"]}
      end

    [
      Kino.SmartCell.quoted_to_string(inputs),
      Kino.SmartCell.quoted_to_string(source_ast)
    ]
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
        <div class="app header">
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

    .header {
      display: grid;
      grid-template-columns: 3fr 1fr 1fr;
      gap: 8px;
    }
    """
  end
end
