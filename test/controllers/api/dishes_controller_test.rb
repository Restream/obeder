require 'test_helper'

class Api::DishesControllerTest < ActionController::TestCase
  setup do
    @dish = create :dish
    @dish_attrs = attributes_for :dish, :salad
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'create' do
    post :create, params: { dish: @dish_attrs }
    assert_response :success

    assert { Dish.count == 2 }
  end

  test 'update' do
    put :update, params: { id: @dish, dish: @dish_attrs }
    assert_response :success
  end

  test 'destroy' do
    delete :destroy, params: { id: @dish }
    assert_response :success
  end
end
