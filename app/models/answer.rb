class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :upvotes
  validates :content, :user, :question, presence: true
  validate :no_self_answer, :no_spam_answers

  def no_self_answer
    if question.asker == user
      errors.add(:user, "Cannot answer your own question.")
    end
  end

  def no_spam_answers
    if Answer.find_by(user_id: user.id, question_id: question.id)
      errors.add(:user, "Cannot answer the same question twice")
    end
  end

  def upvote_count
    upvotes.count
  end

end