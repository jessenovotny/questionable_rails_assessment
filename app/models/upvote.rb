class Upvote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :answer
  validates :voter, :answer, presence: true
  validate :no_self_upvote

  def no_self_upvote
    if voter == answer.user
      errors.add("cannot upvote your own answer.")
    end
  end

end