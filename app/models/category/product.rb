class Category::Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :link, presence: true
  validates :document,
            presence: true,
            file_size: {
              maximum: configus.uploader.max_file_size.megabytes.to_i
            }
  validates :rating, presence: true

  belongs_to :group

  after_create :set_document_link

  mount_uploader :document, Category::Group::Product::DocumentUploader, mount_on: :document_store

  def set_document_link
    document_link = products_files_path(id)
    update(document_link: document_link)
  end
end
