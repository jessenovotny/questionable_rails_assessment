class Question < ApplicationRecord
  belongs_to :user
  has_many :question_categories
  has_many :categories, through: :question_categories
  has_many :answers
  has_many :users, through: :answers, as: :answerers
end
