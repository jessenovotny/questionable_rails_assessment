class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    binding.pry

    # user = User.find_or_create_by(:uid => auth['uid']) do |u|
    #   u.name = auth['info']['name']
    #   u.email = auth['info']['email']
    # end
    # session[:user_id] = user.id
  end
 
  def destroy
    session.destroy
    flash[:message] = "Successfully logged out."
    redirect_to root_path
  end

  private
  
  def auth
    request.env['omniauth.auth']
  end
end
