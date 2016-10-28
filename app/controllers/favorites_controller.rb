class FavoritesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @questions = @user.favorited_questions
  end

  def create
    if current_user
      question = Question.find(params[:question_id])
      favorite = question.favorites.build(user_id: current_user.id)
      favorite.save ? favorite.new_favorite = true : Favorite.find_by(question_id: question.id, user_id: current_user.id).delete
      question = Question.find(params[:question_id])
      render json: [favorite, question]
    end
  end
end