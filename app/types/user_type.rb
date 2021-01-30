class UserType < User
  include BaseType

  permit :full_name, :email, :password, :password_confirmation, :position, :organization
  validates :password, allow_blank: :persisted?, presence: :new_record?
end
