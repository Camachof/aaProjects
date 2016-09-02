class SessionsController < ApplicationController

  before_action :is_logged_in

  def new
    render :new
  end

  def create
    login!
  end

  def destroy
    unless current_user.nil?
      current_user.reset_session_token!
    end
    session[:session_token] = nil
    redirect_to cats_url
  end

  # In the User and Session controllers, use a before_action callback to redirect the user
  #  to the cats index if the user tries to visit the login/signup pages when they're already signed in.

end
