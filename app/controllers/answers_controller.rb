class AnswersController < ApplicationController

  def new
    # binding.pry
    @question = Question.find(params[:question_id])
    if current_user == @question.asker
      flash[:error] = "You cannot answer your own question"
      return redirect_to :back
    end
    @answer = Answer.new
  end

  def create
    # binding.pry
    question = Question.find(params[:question_id])
    params[:answer][:question_id] = question.id
    # answer = current_user.answers.build(answer_params).save
    if current_user.answers.build(answer_params).save
      flash[:notice] = "Answer successfully submitted"
      return redirect_to question_path(question)
    else
      redirect_to :back
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end
end

