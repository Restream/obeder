class UserMailer < ApplicationMailer

  def set_password(user)
    @user = user
    mail to: user.email
  end
end
