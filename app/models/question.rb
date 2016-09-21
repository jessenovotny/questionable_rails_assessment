class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User'
  has_many :answers
  has_many :upvotes
  has_many :favorites
  
  has_many :question_categories
  has_many :categories, through: :question_categories

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

  def category_dropdown=(id)
    category = Category.find_by(id: id)
    categories << category unless categories.include?(category) || category.nil?
  end

  def categories_attributes=(category_hash)
    category_hash.values.each do |attribute|
      unless attribute.values.first.empty?
        category = Category.find_or_create_by(attribute)
        categories << category unless categories.include?(category)
      end
    end
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

  def self.favorited

  end
end
