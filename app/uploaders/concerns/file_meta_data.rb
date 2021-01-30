module Concerns::FileMetaData
  def store_meta_data(prefix = mounted_as)
    if file.content_type
      content_type_attr_name = prefix.present? ? "#{prefix}_content_type" : :content_type
      model.send("#{content_type_attr_name}=", file.content_type)
    end
    original_filename_attr_name = prefix.present? ? "#{prefix}_original_filename" : :original_filename
    model.send("#{original_filename_attr_name}=", file.original_filename)
  end
end
