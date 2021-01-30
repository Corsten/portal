class CategorySerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :name

  has_many :groups, include_nested_associations: true
end
