require 'test_helper'

class Api::DishesControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'create' do
    dish_attrs = attributes_for :dish, :salatik

    post :create, params: { dish: dish_attrs }

    assert { response.success? }
  end
end
