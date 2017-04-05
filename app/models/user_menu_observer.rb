class UserMenuObserver < ActiveRecord::Observer
  def after_save(user_menu)
    UserMailer.notify_menu_changed(user_menu.user, user_menu.menu)
  end
end
