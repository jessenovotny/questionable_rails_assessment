class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :upvotes

  # def upvotes
  #   upvotes.count
  # end

  def self.most_upvoted
    binding.pry
    #find answer with the most upvotes
  end
end