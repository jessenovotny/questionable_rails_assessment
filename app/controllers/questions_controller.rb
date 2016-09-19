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
    2.times {@question.categories.build}
  end

  def edit
  end

  def create
    return redirect_to root_path, alert: "You cannot ask questions for another user." unless current_user == User.find(params[:user_id])
    # binding.pry
    @question = current_user.questions.build(question_params)
    return redirect_to @question, notice: 'Question was successfully created.' if @question.save
    flash[:error] = @question.errors.full_messages
    render :new
  end

  def update
    if category = Category.find_by(id: params[:category_id])
      # in questions#show, click current category link to remove from categories #
      @question.categories.delete(category) 
      redirect_to :back
    elsif !my_question?(@question)
      flash[:error] = ["Cannot edit another user's question."]
      redirect_to @question
    elsif @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
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
    params.require(:question).permit(:content, :categories_attributes => [:name] , :category_ids => [])
  end

  def filter_index_by params, request
    if @category = Category.find_by(id: params[:category_id])
      @questions = @category.questions.take(10)
      @filter = "category"
    elsif params[:button] == "newest" || request.env["REQUEST_PATH"].include?("most_recent")
      @filter = "newest"
      @questions = Question.newest
    elsif params[:button] == "most_answered"
      @filter = "most answered"
      @questions = Question.most_answered
    else
      @filter = "oldest"
      @questions = Question.oldest
    end  
  end
end
