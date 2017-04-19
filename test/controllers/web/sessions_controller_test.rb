require 'test_helper'

class Web::SessionsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    post :create, params: { user_sign_in_type: { email: @user.email, password: @user.password } }
    assert_response :redirect
  end

  test 'destroy' do
    sign_in @user

    delete :destroy
    assert_response :redirect
  end
end
