require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test 'send notification email about new user' do
    admin = create :admin_with_notifications

    user = create :user

    email = AdminMailer.new_user_notification(user: user, toke: 'test')

    assert_emails 1 do
      email.deliver_now
    end

    assert_includes email.to, admin.email
  end
end
