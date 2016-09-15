class SessionsController < ApplicationController

  def new
    if logged_in?
      return redirect_to root_path 
    end
    @user = User.new
  end

  def create
    if auth #coming from FB
      user = User.find_or_create_by(:uid => auth['uid'])
      user.username = auth['info']['name']
      user.password = "password"
      user.save
    else #coming from login page
      user = User.find_by(username: params[:user][:username])
      unless user && user.authenticate(params[:user][:password])
        flash[:error] = "Unknown username and/or password"
        return redirect_to :back
      end
    end
    binding.pry
    login(user)
    binding.pry
    redirect_to root_path, notice: "Successfully logged in as #{user.username}"
  end
 
  def destroy
    session.destroy
    redirect_to root_path, notice: "Successfully logged out."
  end

  private
  
  def auth
    request.env['omniauth.auth']
  end
end
