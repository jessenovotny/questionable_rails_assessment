module QuestionsHelper

  def my_question? question
    question.asker == current_user
  end
end
