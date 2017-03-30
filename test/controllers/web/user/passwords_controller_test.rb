require 'test_helper'

class Web::User::PasswordsControllerTest < ActionController::TestCase
  setup do
    @user = create :user, :with_user_menu_dishes
  end

  test 'edit' do
    get :edit, params: { user_id: @user.id }
    assert_response :success
  end

  test 'update' do
    new_password = generate(:string)
    put :update, params: { user_id: @user.id, user_password_edit_type: { password: new_password, password_confirmation: new_password } }
    assert_redirected_to login_path
  end
end
