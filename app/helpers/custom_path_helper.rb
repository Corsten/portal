module CustomPathHelper
  def admin_file_path(file)
    admin_uploads_file_path(file.url_options)
  end
end
