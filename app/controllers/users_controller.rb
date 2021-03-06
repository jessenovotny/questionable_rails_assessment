class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      login(@user)
      redirect_to root_path, notice: 'User was successfully created.'
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end    
  end

  def destroy
    @user.questions.destroy_all
    @user.answers.destroy_all
    @user.upvotes.destroy_all
    @user.favorites.destroy_all
    @user.destroy
    redirect_to root_path, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
