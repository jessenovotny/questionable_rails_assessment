class User < ApplicationRecord
  has_many :questions, foreign_key: 'asker_id'
  has_many :answers
  has_many :upvotes, foreign_key: 'voter_id'
  validates :username, presence: true, uniqueness: true
  has_secure_password

  def most_upvoted_answer
    binding.pry
    answers.order(upvote_count: :desc).first
    answers.map{|answer| answer.upvote_count}.sort.first
  end
end
