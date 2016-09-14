class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :upvotes
  validates :content, :user, :question, presence: true
  validate :no_self_answer

  def no_self_answer
    if question.asker == user
      errors.add(:user, "cannot answer your own question.")
    end
  end

  def upvote_count
    upvotes.count
  end

end