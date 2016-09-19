class Upvote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :answer
  
  validates :voter, :answer, presence: true
  validate :no_self_upvote, :no_spam_upvote

  def no_self_upvote
    if voter == answer.user
      errors.add(:voter, "cannot upvote your own answer.")
    end
  end

  def no_spam_upvote
    if upvote = Upvote.find_by(voter_id: voter_id, answer_id: answer_id)
      errors.add(:answer, "#{upvote.id}")
    end
  end

end