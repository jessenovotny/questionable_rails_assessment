class Category < ApplicationRecord
  has_many :question_categories
  has_many :questions, through: :question_categories

  validates :name, presence: true, uniqueness: true

  def category_attributes=(attributes_hash)
  end

  def self.all_for question
    all.map{|category| category unless question.categories.include?(category)}.compact
  end
end