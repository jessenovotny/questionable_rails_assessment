class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # binding.pry
    if auth #coming from FB
      user = User.find_or_create_by(:uid => auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
      end
    else #coming from login page
      user = User.find_by(username: params[:user][:username])
      unless user && user.authenticate(params[:user][:password])
        flash[:alert] = "Unknown username and/or password"
        return redirect_to :back
      end
    end
    login(user)
    flash[:notice] = "Successfully logged in as #{user.username}"
    redirect_to root_path
  end
 
  def destroy
    session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end

  private
  
  def auth
    request.env['omniauth.auth']
  end
end
