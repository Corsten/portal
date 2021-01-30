require 'base64'

class WorkingGroupMemberSerializer < ActiveModel::Serializer
  attributes :full_name, :position, :photo

  attribute :photo do
    object.base64_photo
  end
end
