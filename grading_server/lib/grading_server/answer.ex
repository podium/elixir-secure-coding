defmodule GradingServer.Answer do
  @moduledoc """
  This is a representation of an answer.
  """

  @enforce_keys [:question_id, :module_id, :answer, :help_text]
  defstruct [:question_id, :module_id, :answer, :help_text]

  @type t :: %__MODULE__{
          module_id: integer(),
          question_id: integer(),
          answer: String.t(),
          help_text: String.t()
        }
end
