require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  setup do
    @user = create :user_with_user_menus
    sign_in @user
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
