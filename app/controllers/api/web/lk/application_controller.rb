class Api::Web::Lk::ApplicationController < Api::Web::ApplicationController
  class UserNotAuthenticated < StandardError; end

  before_action :raise_error_if_user_not_signed_in
  after_action :renew_user_auth_token!

  rescue_from UserNotAuthenticated, with: :auth_error

  private

  def auth_error
    render_error(:forbidden, :auth_error, t('api.errors.auth_error'))
  end
end
