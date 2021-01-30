class Category::Group::Product::DocumentUploader < ApplicationUploader
  include Concerns::FileMetaData

  storage :postgresql_lo

  process store_meta_data: :document

  def extension_white_list
    %i[gif bmp jpg jpeg png xlsx xls ods doc docx odt pdf]
  end
end
