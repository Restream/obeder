class UserMenusCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id)
    menu = Menu.find_by(id: id)

    ActiveRecord::Base.transaction do
      User.find_each do |user|
        user_menu = UserMenu.create(user: user, menu: menu, neem: user.neem)
        menu_dishes = menu.menu_dishes.default
        dishes = menu_dishes.map(&:dish)
        user_menu.dishes << dishes
        UserMailer.notify_menu_changed(user, menu)
      end
    end
  end
end
