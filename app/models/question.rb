class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User'

  has_many :question_categories
  has_many :categories, through: :question_categories
  
  has_many :answers
  has_many :respondents, through: :answers, class_name: 'User'

  has_many :upvotes

  validates :content, presence: true

  accepts_nested_attributes_for :categories

  def top_answer
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}.first
  end

  def sort_answers_by_upvotes
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}
  end

  def answer_count
    answers.count
  end

  def new_category_name=(category_name)
    categories << Category.find_or_create_by(name: category_name)
  end

  def category_id=(cat_id)
    categories << Category.find(cat_id) unless cat_id.empty?
  end
end
