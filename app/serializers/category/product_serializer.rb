class Category::ProductSerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :group_id, :category_id, :name, :manufacturer, :link, :created_at, :document_link, :rating

  def category_id
    object.group.category_id
  end
end
