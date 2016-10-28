class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :my_answer?, :my_question?

  def logged_in?
    true if current_user
  end

  def current_user
    User.find_by(id: session[:id])
  end

  def login(user)
    session[:id] = user.id
  end

  def my_answer? answer
    answer.user == current_user
  end

  def my_question? question
    question.asker == current_user
  end

end
