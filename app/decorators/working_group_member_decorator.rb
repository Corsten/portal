class WorkingGroupMemberDecorator < ApplicationDecorator
  decorates 'working_group_member'

  def base64_photo
    return nil if object.photo.read.blank?

    file_base64 = Base64.encode64(object.photo.read)
    "data:#{object.photo_content_type};base64,#{file_base64}"
  end
end
