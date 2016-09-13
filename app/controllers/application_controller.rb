class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def logged_in?
    true if current_user
  end

  def current_user
    # find current user from session
  end
end
