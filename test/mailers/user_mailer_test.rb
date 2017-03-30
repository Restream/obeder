require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = create :user
  end

  test 'change_password' do
    mail = UserMailer.change_password(@user)
    assert_equal [@user.email], mail.to
    assert_equal ['noreply@restream.rt.ru'], mail.from
  end
end
