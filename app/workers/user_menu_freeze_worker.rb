class UserMenuFreezeWorker
  include Sidekiq::Worker

  def perform
    tomorrow_user_menus = UserMenu.joins(:menu, :user).where(menus: { date: Date.tomorrow })
    tomorrow_user_menus.update(editable: false)

    neem_user_menus = tomorrow_user_menus.where(users: { neem: true })
    neem_user_menus.update(neem: true)
  end
end
