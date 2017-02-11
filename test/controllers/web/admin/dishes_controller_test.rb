require 'test_helper'

class Web::Admin::DishesControllerTest < ActionController::TestCase
  setup do
    admin_http_login
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
