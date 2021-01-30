class Api::UserUpdatePasswordType < User
  include BaseType

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
