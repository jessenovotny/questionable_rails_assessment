class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def most_upvoted
    binding.pry
    all.sort.first
  end
end
