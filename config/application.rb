# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

require 'hamlit'
require 'configus'
require File.expand_path('../lib/configus', __dir__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')
    config.load_defaults 5.2

    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :resque

    config.action_controller.permit_all_parameters = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Regexp.new(/http?.*rt\.ru(:[0-9]+)?$/)
        resource '*', headers: :any, methods: %i[get post put patch delete options]
      end
    end
  end
end
