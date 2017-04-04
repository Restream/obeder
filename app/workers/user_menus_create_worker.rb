class UserMenusCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id)
    menu = Menu.find_by(id: id)

    ::MenusService.create_user_menus(menu) if menu.present?
  end
end
