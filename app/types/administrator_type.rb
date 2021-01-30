class AdministratorType < Administrator
  include BaseType

  permit :surname, :name, :patronymic, :email, :role, :password, :password_confirmation
  validates :password, allow_blank: :persisted?, presence: :new_record?
end
