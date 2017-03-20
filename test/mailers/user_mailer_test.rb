require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = create :user
  end

  test 'set_password' do
    mail = UserMailer.set_password(@user)
    assert_equal [@user.email], mail.to
    assert_equal ['noreply@restream.rt.ru'], mail.from
  end

end
