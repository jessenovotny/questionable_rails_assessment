class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]


  def index
    binding.pry
    if @user = User.find_by(id: params[:user_id]) 
      @questions = @user.questions
    elsif @category = Category.find_by(id: params[:category_id])
      @questions = @category.questions
    else
      @questions = Question.all
    end    
  end


  def show
  end

  def new
    unless current_user == User.find(params[:user_id])
      flash[:alert] = "You cannot ask questions for another user."
      return redirect_to root_path
    end
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
      redirect_to root_path, altert: "You cannot ask questions for another user."
    end
  end

  def update
    binding.pry
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
