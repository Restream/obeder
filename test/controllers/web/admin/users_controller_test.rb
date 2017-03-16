require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create :user, neem: false
    @user_attrs = attributes_for :user
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

  test 'create' do
    user_count = User.count
    post :create, params: { user: @user_attrs }
    assert_response :redirect
    assert { User.count == user_count + 1 }
  end

  test 'edit' do
    get :edit, params: { id: @user.id }
    assert_response :success
  end

  test 'update' do
    new_email = 'test@restream.rt.ru'
    put :update, params: { id: @user.id,
                           user: { email: new_email } }
    assert { @user.reload.email = new_email }
  end

end
