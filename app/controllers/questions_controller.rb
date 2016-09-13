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
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        redirect_to @question, notice: 'Question was successfully created.'
      else
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        redirect_to @question, notice: 'Question was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      redirect_to questions_url, notice: 'Question was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:query, :user_id)
    end
end
