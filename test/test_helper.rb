ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/autorun'
require 'webmock/minitest'
require 'resque_unit'
require 'resque_unit_scheduler'

Dir[File.expand_path(Rails.root.join('test', 'support', '**', '*.rb'), __FILE__)].each { |f| require f }

class ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include FactoryBot::Syntax::Methods
  include Concerns::Auth
end
