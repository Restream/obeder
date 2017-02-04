require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  setup do
    http_login
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
