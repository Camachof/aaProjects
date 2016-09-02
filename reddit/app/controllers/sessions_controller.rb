class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    #validate login user exists?
    user_name = session_params[:user_name]
    password = session_params[:password]
    user = User.find_by_credentials(user_name, password)

    if user.nil?
      flash[:errors] = "Username or password incorrect!"
      redirect_to new_session_url
    else
      login!(user)
      redirect_to root_url
    end
  end

  def destroy
    if current_user
      logout!(current_user)
    end
    redirect_to root_url
  end

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
