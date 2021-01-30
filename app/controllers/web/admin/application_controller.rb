class Web::Admin::ApplicationController < Web::ApplicationController
  auto_session_timeout configus.administrators.administrator_session_lifetime.hours

  include Concerns::SessionSearch

  helper_method :current_administrator, :administrator_signed_in?

  private

  def policy(*args)
    super([:admin, *args])
  end

  def policy_scope(scope)
    super([:admin, scope])
  end
end
