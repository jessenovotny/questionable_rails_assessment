class AnswersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers
  end

  def new
    @question = Question.find(params[:question_id])
    if current_user == @question.asker
      flash[:error] = "You cannot answer your own question"
      return redirect_to :back
    end
    @answer = Answer.new
  end

  def create
    answer = current_user.answers.build(answer_params)
    if answer.save
      flash[:notice] = "Answer successfully submitted"
      return redirect_to question_path(answer.question)
    else
      flash[:error] = answer.errors.messages[:user]
      redirect_to :back
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    answer = Answer.find(params[:id])
    if answer.update(answer_params)
      flash[:notice] = "Answer successfully updated"
      return redirect_to question_path(answer.question)
    else
      flash[:error] = answer.errors.messages[:user]
      redirect_to :back
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end
end

