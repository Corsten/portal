class Administrator < ApplicationRecord
  include AdministratorRepository
  extend Enumerize

  has_secure_password

  ADMINISTRATOR_ROLES = %w[admin].freeze
  enumerize :role, in: ADMINISTRATOR_ROLES, default: :admin

  validates :surname, :name, :role, presence: true
  validates :email, presence: true, uniqueness: true, email: { reject_one_level_domain: true, high_domain_min_length: 2 }
  validates :password, custom_password: true
end
