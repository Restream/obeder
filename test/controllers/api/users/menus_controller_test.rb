require 'test_helper'

class Api::Users::MenusControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'index' do
    get :index, params: { user_id: @user.id }
    assert_response :success
  end
end
