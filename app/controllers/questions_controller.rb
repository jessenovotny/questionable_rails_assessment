class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]


  def index
    @questions = Question.all
  end


  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    if current_user == User.find(params[:user_id])
      params[:question][:asker_id] = current_user.id
      @question = Question.create(question_params)
      if @question.valid?
        return redirect_to @question, notice: 'Question was successfully created.'
      else
        render :new
      end
    else 
      flash[:alert] = "You cannot ask questions for another user."
      redirect_to root_path
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:content, :asker_id)
    end
end
