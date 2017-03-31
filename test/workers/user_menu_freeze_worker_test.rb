require 'test_helper'

class UserMenuFreezeWorkerTest < ActiveSupport::TestCase
  setup do
    @em_users = create_list :user, 5, neem: false
    @neem_users = create_list :user, 5, neem: true
    menu = create :menu, date: Date.tomorrow
    users = @em_users + @neem_users
    users.each { |user| create :user_menu, user: user, menu: menu, neem: false }
  end

  test 'user_menus_freeze' do
    worker = UserMenuFreezeWorker.new
    worker.perform

    @em_users.each do |user|
      user.reload
      assert user.user_menus.where(neem: false).exists?
      assert user.user_menus.where(neem: true).empty?
    end

    @neem_users.each do |user|
      user.reload
      assert user.user_menus.where(neem: true).exists?
      assert user.user_menus.where(neem: false).empty?
    end
  end
end
