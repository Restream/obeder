require 'test_helper'

class Web::Admin::MonthlyReportsControllerTest < ActionController::TestCase
  setup do
    @admin = create :user, :admin
    sign_in @admin
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'export' do
    get :export, params: { month: Date.current.month, year: Date.current.year }
    assert_response :success
    assert_equal 'application/vnd.ms-excel', response.content_type
  end
end
