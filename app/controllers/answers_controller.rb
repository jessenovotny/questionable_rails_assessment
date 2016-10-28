class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy, :show]
  before_action :set_question, only: [:new, :edit]

  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers_sorted_by_upvotes
    @questions = @answers.map{|a| a.question}
  end

  def show
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
    render_answer_form(@answer, @question)
  end

  def create
    answer = current_user.answers.build(answer_params)
    if answer.save
      if !!params[:first_answer]
        @question = answer.question
        redirect_to question_path(@question), notice: "Answer successfully submitted"
      else
        @answers = answer.question.answers
        render_question_answers(@answers)
      end
    else
      flash[:error] = answer.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    render_answer_form(@answer, @question)
  end

  def update
    if @answer.update(answer_params)
      @answers = @answer.question.answers
      render_question_answers(@answers)
    else
      flash[:error] = @answer.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    return redirect_to questions_path, notice: 'Cannot delete another users answer.' unless my_answer?(@answer)
    @answer.destroy
    @answers = @answer.question.answers
    render_question_answers(@answers)
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

  def render_question_answers answers
    render partial: "answers/question_answer", collection: @answers
  end

  def render_answer_form answer, question
    render partial: 'answers/form', locals: {answer: answer, question: question}
  end
end

