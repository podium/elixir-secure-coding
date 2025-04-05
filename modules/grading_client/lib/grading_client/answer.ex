defmodule GradingClient.Answer do
  @enforce_keys [:question_id, :module_id, :answer, :help_text]
  defstruct [:question_id, :module_id, :answer, :help_text]

  @type t :: %__MODULE__{
          module_id: term(),
          question_id: term(),
          answer: term(),
          help_text: term()
        }
end
