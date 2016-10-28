class SessionsController < ApplicationController

  def new
    @referral_path = request.env["HTTP_REFERER"]
    # binding.pry
    return redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    # binding.pry
    if auth #coming from FB
      user = User.find_or_create_by(:uid => auth[:uid])
      user.username = auth[:info][:name]
      user.password = "password"
      user.save
      unless user.valid?
        flash[:errors] = user.errors.full_messages
        return redirect_to root_path
      end
    else #coming from login page
      user = User.find_by(username: params[:user][:username])
      referral_path = params[:user][:referral_path]
      unless user && user.authenticate(params[:user][:password])
        flash[:error] = ["Unknown username and/or password"]
        return redirect_to :back
      end
    end
    login(user)
    redirect_to referral_path || root_path, notice: "Successfully logged in as #{user.username}"
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
