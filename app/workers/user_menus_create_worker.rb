class UserMenusCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(menu_id)
    menu = Menu.find_by(id: menu_id)

    ActiveRecord::Base.transaction do
      User.find_each do |user|
        user_menu = UserMenu.create(user: user, menu: menu, neem: user.neem)
        menu_dishes = menu.menu_dishes.default
        user_menu.dishes << menu_dishes.map(&:dish)
      end
      menu.publish!
    end
  end
end
