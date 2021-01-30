class Category::Group::Pilot::ImportUploader < ApplicationUploader
  include Concerns::FileMetaData

  storage :postgresql_lo

  process store_meta_data: :document

  def extension_white_list
    %i[xlsx xls csv]
  end
end
