require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user_with_user_menus, neem: false
    @admin = create :user, :admin
    sign_in @admin
    @user_attrs = attributes_for :user
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    assert_difference('User.count', +1) do
      post :create, params: { user: @user_attrs }
    end
    assert_redirected_to admin_users_path
  end

  test 'edit' do
    get :edit, params: { id: @user.id }
    assert_response :success
  end

  test 'update' do
    new_email = generate(:email)
    put :update, params: { id: @user.id, user: { email: new_email } }
    assert { @user.reload.email = new_email }
    assert_response :redirect
  end

   test 'destroy' do
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user.id }
    end
    assert_redirected_to admin_users_path
  end

end
