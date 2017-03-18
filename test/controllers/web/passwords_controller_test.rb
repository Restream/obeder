require 'test_helper'

class Web::PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get web_passwords_edit_url
    assert_response :success
  end

end
