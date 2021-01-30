class User < ApplicationRecord
  include Concerns::SoftDeletable
  include UserRepository

  has_secure_password

  has_many :tokens, dependent: :destroy, class_name: 'User::Token'
  has_many :imports, dependent: :nullify, class_name: 'Category::Pilot::Import'
  has_many :testing_methods, dependent: :nullify, class_name: 'Category::TestingMethod'
  has_many :event_claims, dependent: :destroy, class_name: 'Event::Claim'

  validates :phone_number, phone: true
  validates :organization, presence: true
  validates :position, presence: true
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: { reject_one_level_domain: true, high_domain_min_length: 2 }
  validates :password, custom_password: true
end
