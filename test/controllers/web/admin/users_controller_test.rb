require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    admin_http_login
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'edit' do
    get :edit
    assert_response :success
  end

end
