class AnswersController < ApplicationController

  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :edit]

  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers_sorted_by_upvotes
    # @questions = @user.answers_sorted_by_upvotes.map{|answer| answer.question }
    # binding.pry
  end

  def new
    if current_user == @question.asker
      flash[:error] = ["You cannot answer your own question"]
      return redirect_to :back
    end
    @answer = @question.answers.build
  end

  def create
    answer = current_user.answers.build(answer_params)
    return redirect_to question_path(answer.question), notice: "Answer successfully submitted" if answer.save
    flash[:error] = answer.errors.full_messages
    render :new
  end

  def edit
  end

  def update
    return redirect_to question_path(@answer.question), notice: "Answer successfully updated" if @answer.update(answer_params)
    flash[:error] = @answer.errors.full_messages
    redirect_to :back
  end

  def destroy
    return redirect_to questions_path, notice: 'Cannot delete another users answer.' unless my_answer?(@answer)
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

  def set_question
    @question = Question.find(params[:question_id])
  end
end

