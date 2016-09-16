class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    filter_index_by(params, request)
  end

  def show
    @answers = @question.answers_sorted_by_upvotes
  end

  def new
    return redirect_to root_path, alert: "You cannot ask questions for another user." unless current_user == User.find(params[:user_id])
    @question = Question.new
  end

  def edit
  end

  def create
    return redirect_to root_path, alert: "You cannot ask questions for another user." unless current_user == User.find(params[:user_id])
    @question = Question.create(question_params)
    return redirect_to @question, notice: 'Question was successfully created.' if @question.valid?
    flash[:error] = @question.errors.full_messages
    render :new
  end

  def update
    if question = Question.find_by(id: params[:question_id])
      question.categories.delete(Category.find(params[:id]))
      redirect_to :back
    elsif params[:question][:content] && !my_question?(@question)
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
    return redirect_to questions_path, notice: 'Cannot delete another users question.' unless my_question?(@question)
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :asker_id, :category_name, :new_category_name, :category_ids => [])
  end

  def no_update params
    params[:category_name].empty? if params[:category_name]
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
      @questions = Question.most_answered
    else
      @oldest = true
      @questions = Question.oldest
    end  
  end
end
