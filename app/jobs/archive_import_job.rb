require 'resque-retry'

class ArchiveImportJob
  @queue = :archive_import

  def self.perform(options = {})
    import_data = Category::Archive.find(options['id'])
    user = import_data.user

    AdminMailer.new_archive_import_notification(
      created_at: import_data.created_at,
      user: user,
      document: import_data.document,
      original_filename: import_data.document_original_filename,
      content_type: import_data.document_content_type
    ).deliver_now
  end
end
