class DishesService
  class << self
    def set_default_dishes_for_user(user)
      menus = Menu.where('date >= ?', Date.current).ready
      menus.each do |menu|
        user_menu = UserMenu.create(user: user, menu: menu, neem: user.neem)
        menu_dishes = menu.menu_dishes.default.includes(:dish)
        dishes = menu_dishes.map(&:dish)
        user_menu.dishes << dishes
      end
    end
  end
end
