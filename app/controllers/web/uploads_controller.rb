class Web::UploadsController < Web::ApplicationController
  include Concerns::Uploads
  rescue_from NameError, ActionController::MissingFile, Pundit::NotAuthorizedError, with: :raise_not_found

  before_action :authorize_client!

  def file
    authorize_file
    send_data resource_file.file.read, type: resource_object.content_typedistrict.rb
  end

  private

  def authorize_client!
    raise_not_found unless client_signed_in?
  end

  def pundit_user
    current_client
  end
end
