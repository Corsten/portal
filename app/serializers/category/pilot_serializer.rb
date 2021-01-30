class Category::PilotSerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :group_id, :category_id, :customer_name, :supplier_name, :software_name,
             :manufacturer_name, :in_rsr, :registry_link, :leader_state,
             :unfunctional_requirements, :functional_requirements, :status, :result, :notes, :manufacturer_link, :customer_link

  def category_id
    object.group.category_id
  end
end
