require 'resque-retry'

class UserRegistrationJob
  extend Resque::Plugins::ExponentialBackoff
  @queue = :mailer
  @backoff_strategy = configus.mailer.backoff_strategy

  def self.perform(id)
    user = User.find(id)
    AdminMailer.new_user_notification(user: user, token: 'test').deliver_now
  end
end
