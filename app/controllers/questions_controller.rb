class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :options]

  def index
    path = request.env["REQUEST_PATH"]
    path = path.split("/").last unless path == "/"
    filter_index_by(params, path)
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
    @question = current_user.questions.build(question_params)
    return redirect_to @question, notice: 'Question was successfully created.' if @question.save
    flash[:error] = @question.errors.full_messages
    render :new
  end

  def update
    if logged_in?
      if category = Category.find_by(id: params[:category_id])
        # in questions#show, click current category link to remove from categories #
        @question.categories.delete(category) 
        render partial: 'question_categories', locals: {question: @question}
      elsif !!params[:add_categories]
        @question.update(question_params)
        render partial: 'question_categories', locals: {question: @question}
      elsif @question.update(question_params)
        redirect_to @question, notice: 'Question was successfully updated.'
      elsif params[:question][:content] && !my_question?(@question)
        flash[:error] = ["Cannot edit another user's question."]
        redirect_to @question
      else
        flash[:error] = @question.errors.full_messages
        render :edit
      end
    else
      redirect_to @question
    end
  end

  def destroy
    return redirect_to questions_path, notice: 'Cannot delete another users question.' unless my_question?(@question)
    @question.destroy
    redirect_to root_path, notice: 'Question was successfully destroyed.'
  end

  def options
    render partial: 'question_options', locals: {question: @question}
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :category_dropdown, :categories_attributes => [:name] , :category_ids => [])
  end

  def filter_index_by params, path
    if @category = Category.find_by(id: params[:category_id])
      @questions = @category.questions
      @filter = "category"
    elsif path == "most_recent"
      @filter = path
      @questions = Question.newest
    elsif path == "top_answers"
      @filter = path
      @questions = Question.top_answers
    elsif path == "oldest"
      @filter = path
      @questions = Question.oldest
    else
      @filter = "most_popular"
      @questions = Question.most_popular
    end  
  end
end
