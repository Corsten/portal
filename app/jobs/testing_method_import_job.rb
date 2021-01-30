require 'resque-retry'

class TestingMethodImportJob
  @queue = :testing_method_import

  def self.perform(options = {})
    import_data = Category::TestingMethod.find(options['id'])
    user = import_data.user

    AdminMailer.new_testing_method_import_notification(
      created_at: import_data.created_at,
      user: user,
      document: import_data.document,
      original_filename: import_data.document_original_filename,
      content_type: import_data.document_content_type
    ).deliver_now
  end
end
