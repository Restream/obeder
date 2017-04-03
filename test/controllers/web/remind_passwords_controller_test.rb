require 'test_helper'

class Web::RemindPasswordsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'edit' do
    get :edit
    assert_response :success
  end

  test 'update' do
    post :update, params: { user_remind_password_type: { email: @user.email } }
    assert_response :redirect
  end
end
