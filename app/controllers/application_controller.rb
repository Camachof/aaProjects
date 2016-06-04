class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def current_user
    return nil if session[:session_token].nil?
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    current_user ? true : false
  end

  def must_be_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def must_be_logged_out
    redirect_to :root if logged_in?
  end

end
