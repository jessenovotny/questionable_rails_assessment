class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User'

  has_many :question_categories
  has_many :categories, through: :question_categories
  
  has_many :answers
  has_many :respondents, through: :answers, class_name: 'User'

  has_many :upvotes

  validates :content, presence: true

  def top_answer
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}.first
  end

  def sort_answers_by_upvotes
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}
  end

  def answer_count
    answers.count
  end
end
