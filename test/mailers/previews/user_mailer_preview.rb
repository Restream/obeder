# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def change_password
    UserMailer.change_password(User.first)
  end

  def notify_menu_changed
    UserMailer.notify_menu_changed(User.first, Menu.first)
  end
end
