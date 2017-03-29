require 'test_helper'

class Api::Admin::MenusControllerTest < ActionController::TestCase
  setup do
    @menu = create :menu
  end

  test 'validate' do
    get :validate, params: { date: @menu.date.to_s }
    assert_response :success
  end
end
