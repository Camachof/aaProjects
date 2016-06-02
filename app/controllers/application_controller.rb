class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @user ||= User.find_by(session_token: session[:session_token])
  end

  def login!
    user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if user.nil?
      render :new
    else
      token = user.generate_session_token
      session[:session_token] = token
      redirect_to cats_url
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def is_logged_in
    if current_user && params[:action] != 'destroy'
      redirect_to cats_url
    end
  end

end
