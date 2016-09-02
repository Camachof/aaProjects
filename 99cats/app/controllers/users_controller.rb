class UsersController < ApplicationController
  before_action :is_logged_in

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # send email
      msg = UserMailer.welcome_email(@user)
      msg.deliver
      login!
    else
      render :new
    end
  end

end
