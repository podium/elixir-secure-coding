defmodule GradingServer.Key.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :answer, :string
    field :help_text, :string
    field :question_id, :integer

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:question_id, :answer, :help_text])
    |> validate_required([:question_id, :answer, :help_text])
  end
end
