require 'resque-retry'

class NewEventClaimJob
  extend Resque::Plugins::ExponentialBackoff
  @queue = :mailer
  @backoff_strategy = configus.mailer.backoff_strategy

  def self.perform(options = {})
    user = User.find(options['user_id'])
    claim = Event::Claim.find(options['claim_id'])
    AdminMailer.new_event_claim_notification(user: user, claim: claim).deliver_now
  end
end
