class ApplicationController < ActionController::Base
  include Concerns::Auth
  include Concerns::CustomUrlHelper
  include Pundit
  protect_from_forgery with: :exception, prepend: true

  def raise_not_found(err = nil)
    err.backtrace.each { |backtrace_line| Rails.logger.error(backtrace_line) } if err.respond_to?(:backtrace)
    raise ActionController::RoutingError, 'Not found'
  end
end
