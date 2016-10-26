class AnswersController < ApplicationController
  # respond_to :html, :js, :erb, :json
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :edit]

  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers_sorted_by_upvotes
  end

  def show
    set_answer
    respond_to do |format|
      format.html {redirect_to :back}
      format.json {render json: @answer}
    end
  end

  def new
    if current_user == @question.asker
      flash[:error] = ["You cannot answer your own question"]
      return redirect_to :back
    end
    @answer = @question.answers.build
    render partial: 'answers/form', locals: {answer: @answer, question: @question}
  end

  def create
    answer = current_user.answers.build(answer_params)
    # binding.pry
    if answer.save
      @answers = answer.question.answers
      render partial: "questions/question_answers", locals: {answers: @answers}
    else
    # return redirect_to question_path(answer.question), notice: "Answer successfully submitted" if answer.save
      flash[:error] = answer.errors.full_messages
      render :back
    end
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
    redirect_to :back, notice: 'Answer was successfully destroyed.'
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

