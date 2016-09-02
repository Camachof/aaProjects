class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end
  
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to :root
    else
      render :new
    end
  end

  #no sensitive information
  def show
    user = User.find_by(user_name: user_params[:user_name])
    @user_public_data = user.posts
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
