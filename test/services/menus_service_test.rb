require 'test_helper'

class MenuServiceTest < ActiveSupport::TestCase
  setup do
    @user = create :user
    @menu = create :menu, ready: true
  end

  test 'menu_service_create' do
    ::MenusService.create_user_menus(@menu)

    @user.reload
    p User.all
    assert @user.user_menus.where(menu: @menu).exists?
  end
end
