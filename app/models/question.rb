class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User'

  has_many :question_categories
  has_many :categories, through: :question_categories
  
  has_many :answers
  has_many :respondents, through: :answers, class_name: 'User'

  has_many :upvotes

  validates_presence_of :content, :message => "Question cannot be blank" 

  accepts_nested_attributes_for :categories

  def top_answer
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}.first
  end

  def answers_sorted_by_upvotes
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}
  end

  def answer_count
    answers.count
  end

  def new_category_name=(category_name)
    categories << Category.find_or_create_by(name: category_name) unless category_name.empty?
  end

  def category_ids=(cat_ids)
    cat_ids.each do |cat_id|
      categories << Category.find(cat_id) unless cat_id.empty?
    end
  end

  def category_name=(cat_name)
    categories << Category.find(cat_name) unless cat_name.empty?
  end

  def self.newest
    all.reverse.take(10)
  end

  def self.oldest
    all.limit(10)
  end

  def self.most_answered
    all.sort_by{|q| q.answer_count}.reverse.take(10)
  end
end
