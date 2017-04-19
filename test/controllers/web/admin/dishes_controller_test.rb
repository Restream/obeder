require 'test_helper'

class Web::Admin::DishesControllerTest < ActionController::TestCase
  setup do
    @user = create :user, :cook
    sign_in @user
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
