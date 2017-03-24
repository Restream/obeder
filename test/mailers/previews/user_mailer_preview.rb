# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def set_password
    UserMailer.set_password(User.first)
  end
end
