class MenusService
  class << self
    def create_user_menus(menu)
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
