require 'test_helper'

class Api::User::MenusControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
