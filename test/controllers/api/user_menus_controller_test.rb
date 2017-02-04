require 'test_helper'

class Api::UserMenusControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'update' do
    user_menu = create :user_menu
    user_menu_attrs = attributes_for :user_menu
    user_menu_attrs[:dishes] = attributes_for_list(:dish, 3)

    put :update, params: { id: user_menu.id, user_menu: user_menu_attrs }
    assert_response :success
  end

  test 'update remove dishes' do
    user_menu = create :user_menu, :with_dishes
    user_menu_attrs = attributes_for :user_menu
    user_menu_attrs[:dishes] = []
    put :update, params: { id: user_menu.id, user_menu: user_menu_attrs }
    assert_response :success
    assert { UserMenuDish.count.zero? }
  end

  test 'update remove dish' do
    user_menu = create :user_menu, :with_dishes
    user_menu_attrs = attributes_for :user_menu
    user_menu_attrs[:dishes] = [Dish.first.as_json]
    put :update, params: { id: user_menu.id, user_menu: user_menu_attrs }
    assert_response :success
    assert { MenuDish.count == 1 }
  end
end
