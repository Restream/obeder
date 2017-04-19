class MenusService
  class << self
    def create_user_menus(menu)
      UserMenusCreateWorker.new.perform(menu.id)
    end

    def notify_menu_published(menu)
      UserMenusNotifyWorker.new.perform(menu.id)
    end
  end
end
