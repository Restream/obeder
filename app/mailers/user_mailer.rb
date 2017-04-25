class UserMailer < ApplicationMailer
  add_template_helper Web::Admin::MenusHelper

  def change_password(user)
    @user = user.decorate
    mail to: user.email
  end

  def notify_menu_changed(user, menu)
    @user = user.decorate
    @menu = menu
    mail(
      to: user.email,
      subject: I18n.t('user_mailer.notify_menu_changed.subject', date: I18n.l(menu.date))
    )
  end
end
