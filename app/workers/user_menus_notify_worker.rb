class UserMenusNotifyWorker
  include Sidekiq::Worker

  def perform(menu_id)
    menu = Menu.find_by(id: menu_id)

    User.find_each do |user|
      UserMailer.notify_menu_changed(user, menu)
    end
  end
end
