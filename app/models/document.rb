class Document < ApplicationRecord
  include Rails.application.routes.url_helpers
  include DocumentRepository
  extend Enumerize

  validates :name, presence: true
  validates :document,
            presence: true,
            file_size: {
              maximum: configus.uploader.max_file_size.megabytes.to_i
            }

  after_create :set_document_link

  KINDS = %i[decree protocol presentation government_decree federal_law other pilot_template].freeze

  enumerize :kind, in: KINDS

  validates :kind, presence: true

  mount_uploader :document, Document::DocumentUploader, mount_on: :document_store

  def set_document_link
    document_link = main_page_documents_files_path(id)
    update(document_link: document_link)
  end
end
