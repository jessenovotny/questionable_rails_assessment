module QuestionsHelper

  def user_has_already_answered question
    current_user ? question.answers.where("user_id = ?", current_user.id).try(:first) : nil
  end

  def answered? question
    true unless question.answers.empty?
  end

end
