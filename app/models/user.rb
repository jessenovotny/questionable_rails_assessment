class User < ApplicationRecord
  has_many :questions, foreign_key: 'asker_id'
  has_many :answers
  has_many :upvotes, foreign_key: 'voter_id'
  validates :username, presence: true, uniqueness: true
  has_secure_password

  def top_answer
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}.first
  end
end
