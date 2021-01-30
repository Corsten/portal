require 'resque-retry'

class UpdateEventsStateJob
  @queue = :default

  def self.perform
    events = Event.scheduled.not_actual(Time.current)

    events.find_each do |event|
      event.update(state: :completed)
    end
  end
end
