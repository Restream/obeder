class MenusService
  class << self
    def create_user_menus(menu)
      UserMenusCreateWorker.perform_async(menu.id)
    end
  end
end
