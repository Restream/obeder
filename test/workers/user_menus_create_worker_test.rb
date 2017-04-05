require 'test_helper'
class UserMenusCreateWorkerTest < ActiveSupport::TestCase
  setup do
    @user = create :user
    @menu = create :menu, aasm_state: :approved
  end

  test 'user_menus_create' do
    worker = UserMenusCreateWorker.new
    worker.perform(@menu.id)

    @user.reload
    assert @user.user_menus.where(menu: @menu).exists?

    @menu.reload
    assert @menu.published?
  end
end
