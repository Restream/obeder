class MenuObserver < ActiveRecord::Observer
  def after_commit(menu)
    MenusService.create_user_menus(menu) if menu.approved?
    MenusService.notify_menu_published(menu) if menu.published?
  end
end
