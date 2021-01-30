class Web::ApplicationController < ApplicationController
  rescue_from NameError, ActionController::MissingFile, Pundit::NotAuthorizedError, with: :raise_not_found

  private

  def authorize_user!
    raise_not_found unless user_signed_in?
  end
end
