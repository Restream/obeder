require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user, neem: false
    sign_in @user
  end

  test 'show' do
    get :show, params: { id: @user.id }
    assert_response :success
  end

  test 'update' do
    put :update, params: { id: @user.id, user: { neem: true } }
    assert_response :success
    assert { @user.reload.neem }
  end
end
