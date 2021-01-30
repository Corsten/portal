class Category::GroupSerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :name, :category_id

  has_many :products
  has_many :pilots
  has_many :testing_methods
  has_many :archives
end
