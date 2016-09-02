class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )

    if @user.nil?
      flash.now[:error] = ["You don't exist!"]
      render :new
    else
      user_login!(@user)
      redirect_to user_url(@user)
    end

  end

  def destroy
    user_logout!
    redirect_to new_session_url
  end

end
