require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'send email for restore password of user' do
    user = create(:user)
    token = TokenService.generate_confirm_email_token(user)
    email = UserMailer.restore_password(user, token)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [user.email], email.to
  end
end
