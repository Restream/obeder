class MenusService
  class << self
    def create_user_menus(menu)
      UserMenusCreateWorker.perform_async(menu.id)
    end

    def notify_menu_changed(menu)
      UserMenusNotifyWorker.perform_async(menu.id)
    end
  end
end
