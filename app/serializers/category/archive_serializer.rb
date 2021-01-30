class Category::ArchiveSerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :group_id, :category_id, :customer_name, :notes, :document_link

  def category_id
    object.group.category_id
  end
end
