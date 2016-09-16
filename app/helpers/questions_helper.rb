module QuestionsHelper

  def my_answer_to question
    question.answers.where("user_id = ?", current_user.id).try(:first)
  end

  def answered? question
    true unless question.answers.empty?
  end

end
