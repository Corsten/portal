require 'singleton'

class TokenStore
  include Singleton

  attr_reader :connection

  def initialize
    @connection = Redis::Namespace.new(:session, redis: configus.redis)
  end
end
