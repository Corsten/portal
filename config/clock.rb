require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(1.day, 'Update calendar events state') do
    Resque.enqueue(UpdateEventsStateJob)
  end
end
