class FavoritesController < ApplicationController

  def index
    # binding.pry
    @user = User.find(params[:user_id])
    @questions = @user.favorited_questions
  end

  def create
    question = Question.find(params[:question_id])
    favorite = question.favorites.build(user_id: current_user.id)
    Favorite.find_by(id: favorite.errors.messages[:question]).try(:destroy) unless favorite.save
    redirect_to :back
  end
end