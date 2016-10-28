class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User'
  has_many :answers
  has_many :upvotes
  has_many :favorites
  
  has_many :question_categories
  has_many :categories, through: :question_categories

  validates_presence_of :content, :message => "Question cannot be blank" 
  validates_uniqueness_of :content, :message => "Question has already been asked" 

  accepts_nested_attributes_for :categories

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

  def top_answer
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}.first
  end

  def answers_sorted_by_upvotes
    answers.sort{|a, b| b.upvote_count <=> a.upvote_count}
  end

  def answer_count
    answers.count
  end

  def favorite_count
    favorites.count
  end

  def favorited_by? current_user
    Favorite.find_by(question_id: self.id, user_id: current_user.try(:id)) ? "   <3   " : "Favorite"
  end

  ### FILTERS ###
  def self.newest
    questions = order(id: :desc).take(10)
    # Kaminari.paginate_array(questions).page(page)
  end

  def self.most_popular
    # binding.pry
    questions = all.sort_by{|q| q.favorite_count}.reverse.take(10)
    # Kaminari.paginate_array(questions).page(page)
  end

  def self.oldest
    questions = order(:id).take(10)
    # Kaminari.paginate_array(questions).page(page)
  end

  def self.top_answers
    questions = Answer.select("answers.*, count(upvotes.id) as upvote_count").joins(:upvotes).group(:id).order('upvote_count DESC').map{|a| a.question}.take(10)
    # Kaminari.paginate_array(questions).page(page)
  end
end
