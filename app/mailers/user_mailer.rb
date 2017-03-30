class UserMailer < ApplicationMailer
  def change_password(user)
    @user = user
    mail to: user.email
  end
end
