class DishesService
  class << self
    def set_default_dishes_for_user(user)
      menus = Menu.ready.where('date >= ?', Date.current)
      menus.each do |menu|
        user_menu = UserMenu.create(user: user, menu: menu, neem: user.neem)
        menu_dishes = menu.menu_dishes.default
        dishes = menu_dishes.map(&:dish)
        user_menu.dishes << dishes
      end
    end
  end
end
