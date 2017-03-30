# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def change_password
    UserMailer.change_password(User.first)
  end
end
