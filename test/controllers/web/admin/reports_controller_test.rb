require 'test_helper'

class Web::Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    @admin = create :user, :admin
    sign_in @admin
  end

  test 'index' do
    get :index
    assert_response :success
  end
end
