class Category::Archive < ApplicationRecord
  include Rails.application.routes.url_helpers

  extend Enumerize

  validates :customer_name, presence: true

  validates :document,
            presence: true,
            file_size: {
              maximum: configus.uploader.max_file_size.megabytes.to_i
            }

  belongs_to :group

  belongs_to :user, required: false

  after_create :set_document_link

  mount_uploader :document, Category::Group::TestingMethod::DocumentUploader, mount_on: :document_store

  def set_document_link
    document_link = archives_files_path(id)
    update(document_link: document_link)
  end
end
