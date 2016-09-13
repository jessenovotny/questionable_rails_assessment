class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :upvotes
  has_many :upvoted_answers, through: :upvotes
  validates :username, presence: true, uniqueness: true
  has_secure_password

  def most_upvoted
    binding.pry
    upvoted_answers.uniq.sort.first
  end
end
