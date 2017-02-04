require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end
end
