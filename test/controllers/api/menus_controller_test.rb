require 'test_helper'

class Api::MenusControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'create' do
    menu_attrs = attributes_for :menu, :ready, :with_dishes

    post :create, params: { menu: menu_attrs }
    assert_response :success

    assert { Menu.count == 1 }
    assert { MenuDish.count == 3 }
  end

  test 'update' do
    menu = create :menu
    menu_attrs = attributes_for :menu, :ready
    menu_attrs[:dishes] = attributes_for_list(:dish, 3)

    put :update, params: { id: menu.id, menu: menu_attrs }
    assert_response :success
  end

  test 'update remove dishes' do
    menu = create :menu, :with_dishes
    menu_attrs = attributes_for :menu, :ready
    put :update, params: { id: menu.id, menu: menu_attrs }
    assert_response :success
    assert { MenuDish.count.zero? }
  end

  test 'update remove dish' do
    menu = create :menu, :with_dishes
    menu_attrs = attributes_for :menu, :ready
    menu_attrs[:dishes] = Dish.first.as_json
    put :update, params: { id: menu.id, menu: menu_attrs }
    assert_response :success
    assert { MenuDish.count == 1 }
  end

  test 'destroy' do
    menu = create :menu

    delete :destroy, params: { id: menu.id }
    assert_response :success
    assert { Menu.count.zero? }
    assert { MenuDish.count.zero? }
  end
end
