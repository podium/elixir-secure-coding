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
    answer: "A",
    help_text: "A"
  }
]

List.flatten([
  to_answers.(OWASP, owasp_questions)
])
