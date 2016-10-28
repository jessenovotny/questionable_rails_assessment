class Favorite < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validate :no_spam_favorite
  attr_accessor :new_favorite
  
  def no_spam_favorite
    if favorite = Favorite.find_by(user_id: user_id, question_id: question_id)
      errors.add(:question, "#{favorite.id}")
    end
  end

end
