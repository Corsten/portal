class Category::Pilot::Import < ApplicationRecord
  validates :document,
            presence: true,
            file_size: {
              maximum: configus.uploader.max_file_size.megabytes.to_i
            }

  belongs_to :user, required: false

  mount_uploader :document, Category::Group::Pilot::ImportUploader, mount_on: :document_store
end
