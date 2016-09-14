module QuestionsHelper

  def my_question? question
    question.asker == current_user
  end

  def my_answer? question
    question.answers.where("user_id = ?", current_user.id).try(:first)
  end

  def answered? question
    true unless question.answers.empty?
  end

end
