defmodule GradingServer.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :question_id, :integer
      add :answer, :string
      add :help_text, :string

      timestamps()
    end
  end
end
