require 'test_helper'

class Api::Admin::MenusControllerTest < ActionController::TestCase
  setup do
    admin_http_login

    @menu = create :menu
  end

  test 'validate' do
    get :validate, params: { date: @menu.date.to_s }
    assert_response :success
  end
end
