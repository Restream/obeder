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
    menu_attrs = attributes_for :menu, :ready, :with_dishes

    put :update, params: { id: menu.id, menu: menu_attrs }
    assert_response :success
  end

  test 'destroy' do
    menu = create :menu

    delete :destroy, params: { id: menu.id }
    assert_response :success
    assert { Menu.count.zero? }
    assert { MenuDish.count.zero? }
  end
end
