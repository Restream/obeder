require 'test_helper'

class Web::Admin::MenusControllerTest < ActionController::TestCase
  setup do
    @menu = create :menu
    @user = create :user, :cook
    sign_in @user
  end

  test 'edit' do
    get :edit, params: { date: @menu.date.to_s }
    assert_response :success
  end

  test 'update' do
    put :update, params: { date: @menu.date, menu: { date: generate(:date) } }
    assert_response :redirect
  end

  test 'approve' do
    put :approve, params: { date: @menu.date.to_s }
    assert_response :redirect
  end
end
