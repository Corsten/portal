require 'resque-retry'

class UserRestorePasswordJob
  extend Resque::Plugins::ExponentialBackoff
  @queue = :mailer
  @backoff_strategy = configus.mailer.backoff_strategy

  def self.perform(id)
    user = User.find(id)
    token = TokenService.generate_restore_password_token(user)
    UserMailer.restore_password(user, token).deliver_now
  end
end
