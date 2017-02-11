require 'test_helper'

class Web::Admin::MenusControllerTest < ActionController::TestCase
  setup do
    http_login

    @menu = create :menu
  end

  test 'edit' do
    get :edit, params: { date: @menu.date.to_s }
    assert_response :success
  end
end
