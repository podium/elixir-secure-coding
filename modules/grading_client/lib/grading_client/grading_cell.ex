defmodule GradingClient.GradingCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Graded"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""

    {:ok, assign(ctx, source: source), editor: [source: source, language: "elixir"]}
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
    %{"source" => ctx.assigns.source}
  end

  @impl true
  def to_source(attrs) do
    try do
      source = Code.string_to_quoted!(attrs["source"])

      ast =
        quote do
          result = unquote(source)

          GradingServer.Answers.check(module_id, question_id, result)
        end

      Kino.SmartCell.quoted_to_string(ast)
    rescue
      error ->
        IO.inspect(error)
        attrs["source"]
    end
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      root.innerHTML = `
        <div class="app">
          Graded Cell
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
