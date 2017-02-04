require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'update' do
    user = create :user, neem: false

    put :update, params: { id: user.id, neem: true }
    assert_response :success
    assert { user.reload.neem }
  end
end
