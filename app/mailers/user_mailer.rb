class UserMailer < ActionMailer::Base
  default from: "mcama200@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://www.google.com'
    mail(to: user.user_name, subject:"whats up man")
  end
end
