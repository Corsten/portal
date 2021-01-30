require 'resque-retry'

class PilotImportJob
  @queue = :pilot_import

  def self.perform(options = {})
    import_data = Category::Pilot::Import.find(options['id'])
    import_options = {
      comment: import_data.notes,
      document: StringIO.new(import_data.document.read)
    }

    PilotsImportService.import(import_options)

    user = User.find(options['user_id'])

    AdminMailer.new_pilot_import_notification(
      created_at: import_data.created_at,
      user: user,
      document: import_data.document,
      original_filename: import_data.document_original_filename,
      content_type: import_data.document_content_type
    ).deliver_now
  end
end
