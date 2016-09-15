class AnswersController < ApplicationController

  before_action :set_answer, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @answers = @user.sort_answers_by_upvotes
  end

  def new
    @question = Question.find(params[:question_id])
    if current_user == @question.asker
      flash[:error] = ["You cannot answer your own question"]
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
      binding.pry
      flash[:error] = answer.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @question = Question.find(params[:question_id])
  end

  def update
    if @answer.update(answer_params)
      flash[:notice] = "Answer successfully updated"
      return redirect_to question_path(@answer.question)
    else
      flash[:error] = @answer.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    return redirect_to questions_path, notice: 'Cannot delete another users answer.' unless current_users?(@answer)
    @answer.destroy
    redirect_to questions_path, notice: 'Answer was successfully destroyed.'
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def current_users? answer
    answer.user == current_user
  end
end

