class Web::Admin::UploadsController < Web::Admin::ProtectedApplicationController
  include Concerns::Uploads
  rescue_from NameError, ActionController::MissingFile, with: :raise_not_found

  def file
    authorize_file(:admin)

    prefix = resource_file.mounted_as

    content_type_attr_name = prefix.present? ? "#{prefix}_content_type" : :content_type

    original_filename_attr_name = prefix.present? ? "#{prefix}_content_type" : :original_filename

    send_data(
      resource_file.file.read,
      type: resource_object.send(content_type_attr_name.to_s),
      filename: resource_object.send(original_filename_attr_name.to_s),
      disposition: 'inline'
    )
  end
end
