class Web::Admin::ProtectedApplicationController < Web::Admin::ApplicationController
  before_action :authenticate_administrator!

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  def forbidden
    redirect_to admin_root_path_for(current_administrator)
  end

  def pundit_user
    Administrator.find_by(id: session[:administrator_id])
  end
end
