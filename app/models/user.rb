class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :upvotes
  validates :username, presence: true, uniqueness: true
  has_secure_password
end
