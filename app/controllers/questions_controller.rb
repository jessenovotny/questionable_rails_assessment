class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]


  def index
    filter_index_by(params, request)
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
        flash[:error] = @question.errors.full_messages
        render :new
      end
    else 
      redirect_to root_path, altert: "You cannot ask questions for another user."
    end
  end

  def update
    if params[:question][:content] && !current_users?(@question)
      flash[:error] = ["Cannot edit another user's question."]
      redirect_to @question
    elsif @question.update(question_params)
      flash[:notice] = 'Question was successfully updated.' unless no_update(question_params)
      redirect_to @question
    else
      flash[:error] = @question.errors.full_messages
      render :edit
    end
  end

  def destroy
    return redirect_to questions_path, notice: 'Cannot delete another users question.' unless current_users?(@question)
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :asker_id, :category_name, :category_ids => [], :new_category_name => [:name])
  end

  def current_users? question
    question.asker == current_user
  end

  def no_update params
    params[:category_name].empty?
  end

  def filter_index_by params, request
    if @user = User.find_by(id: params[:user_id]) 
      @questions = @user.questions.take(10)
    elsif @category = Category.find_by(id: params[:category_id])
      @questions = @category.questions.take(10)
    elsif params[:button] == "newest" || request.env["REQUEST_PATH"].include?("most_recent")
      @questions = Question.newest
      @newest = true
    elsif params[:button] == "most_answered"
      @most_answered = true
      @questions = Question.most_answered.take(10)
    else
      @oldest = true
      @questions = Question.oldest
    end  
  end
end
