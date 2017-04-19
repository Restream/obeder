class UserMenusNotifyWorker
  include Sidekiq::Worker

  def perform(menu_id)
    menu = Menu.find_by(id: menu_id)

    User.find_each { |user| UserMailer.notify_menu_changed(user, menu).deliver }
  end
end
