require 'test_helper'

class UserMenuFreezeWorkerTest < ActiveSupport::TestCase
  setup do
    @em_user = create :user, neem: false
    @neem_user = create :user, neem: true
    menu = create :menu, date: Date.tomorrow

    create :user_menu, user: @em_user, menu: menu, neem: false
    create :user_menu, user: @neem_user, menu: menu, neem: false
  end

  test 'user_menus_freeze' do
    worker = UserMenuFreezeWorker.new
    worker.perform

    @em_user.reload
    assert @em_user.user_menus.where(neem: false).exists?

    @neem_user.reload
    assert @neem_user.user_menus.where(neem: true).exists?
  end
end
