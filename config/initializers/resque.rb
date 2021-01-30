rails_env = Rails.env || ENV['RAILS_ENV'] || 'development'
require 'fakeredis' if rails_env == 'test'

redis_options = { host: ENV.fetch('REDIS_HOST', 'redis'), port: ENV.fetch('REDIS_PORT', '6379'), password: ENV['REDIS_PASSWORD'] }.compact
Resque.redis = Redis.new(redis_options)
Resque.logger.level = Logger::INFO
