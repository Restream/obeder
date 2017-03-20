require 'test_helper'

class Web::Admin::DishesControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end
end
