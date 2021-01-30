require 'resque-retry'

class UserUnblockJob
  extend Resque::Plugins::ExponentialBackoff
  @queue = :mailer
  @backoff_strategy = configus.mailer.backoff_strategy

  def self.perform(id)
    user = User.find(id)
    UserMailer.unblock_user_notification(user).deliver_now
  end
end
