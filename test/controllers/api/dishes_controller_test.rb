require 'test_helper'

class Api::DishesControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'create' do
    dish_attrs = attributes_for :dish, :salatik

    post :create, params: { dish: dish_attrs }
    assert_response :success

    assert { Dish.count == 1 }
  end

  test 'update' do
    dish = create :dish
    dish_attrs = attributes_for :dish, :salatik

    put :update, params: { id: dish.id, dish: dish_attrs }
    assert_response :success
  end

  test 'destroy' do
    dish = create :dish

    delete :destroy, params: { id: dish.id }
    assert_response :success
  end
end
