class WorkingGroupMember::PhotoUploader < ApplicationUploader
  include Concerns::FileMetaData

  storage :postgresql_lo

  process store_meta_data: :photo

  def extension_white_list
    %i[gif bmp jpg jpeg png]
  end
end
