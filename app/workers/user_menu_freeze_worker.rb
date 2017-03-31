class UserMenuFreezeWorker
  include Sidekiq::Worker

  def perform
    users_tomorrow = UserMenu.joins(:menu, :user).where(menus: { date: Date.tomorrow })
    users_tomorrow.update(editable: false)

    neem_users = users_tomorrow.where(users: { neem: true })
    neem_users.update(neem: true)
  end
end
