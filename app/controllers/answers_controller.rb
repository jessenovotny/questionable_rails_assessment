class AnswersController < ApplicationController

  def new
    @answer = Answer.new
  end

  def create
    binding.pry
  end
end

