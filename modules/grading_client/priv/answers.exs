alias GradingClient.Answer

to_answers = fn module_name, answers ->
  Enum.map(answers, fn data ->
    %Answer{
      module_id: module_name,
      question_id: data.question_id,
      answer: data.answer,
      help_text: data[:help_text]
    }
  end)
end

owasp_questions = [
  %{
    question_id: 1,
    answer: :entry_granted_op2,
    help_text: "Research MD5 Rainbow Tables"
  },
  %{
    question_id: 2,
    answer: :plug,
    help_text: "Check the changelog for the next minor or major release of each option."
  }
]

sdlc_questions = [
  %{
    question_id: 1,
    answer: "some-secret-password",
    help_text: "Use System.get_env/1 to get the password from the environment variable."
  }
]

graphql_questions = [
  %{
    question_id: 1,
    answer: :c,
    help_text: "Read the first paragraph of this livebook again!"
  },
  %{
    question_id: 2,
    answer: :a,
    help_text: "Read the first paragraph of this livebook again!"
  }
]

List.flatten([
  to_answers.(OWASP, owasp_questions),
  to_answers.(SDLC, part3_questions),
  to_answers.(GRAPHQL, graphql_questions)
])
