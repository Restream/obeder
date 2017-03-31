class GuzzleWorker
  include Sidekiq::Worker

  def perform
    UserMenu.joins(:user, :menu).where(menus: { date: Date.tomorrow })
      .where(users: { neem: true }).update_all(['neem = ?, editable = ?', true, false])
  end
end
