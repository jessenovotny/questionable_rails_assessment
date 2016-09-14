class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    if current_user == @question.asker
      flash[:error] = "You cannot answer your own question"
      return redirect_to :back
    end
    @answer = Answer.new
  end

  def create
    binding.pry
  end
end

