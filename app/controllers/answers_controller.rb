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
    question = Question.find(params[:question_id])
    params[:answer][:question_id] = question.id
    answer = current_user.answers.build(answer_params)
    if answer.save
      flash[:notice] = "Answer successfully submitted"
      return redirect_to question_path(question)
    else
      flash[:error] = answer.errors.messages[:user]
      # binding.pry
      redirect_to :back
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end
end

