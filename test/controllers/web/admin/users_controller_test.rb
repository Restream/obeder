require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_admin_users_index_url
    assert_response :success
  end

  test "should get new" do
    get web_admin_users_new_url
    assert_response :success
  end

  test "should get edit" do
    get web_admin_users_edit_url
    assert_response :success
  end

end
