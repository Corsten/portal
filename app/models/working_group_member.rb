class WorkingGroupMember < ApplicationRecord
  validates :full_name, presence: true
  validates :position, presence: true

  mount_uploader :photo, WorkingGroupMember::PhotoUploader, mount_on: :photo_store
end
