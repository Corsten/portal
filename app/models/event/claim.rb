class Event::Claim < ApplicationRecord
  include Concerns::SoftDeletable

  validates :full_name, presence: true
  validates :email, presence: true, email: { reject_one_level_domain: true, high_domain_min_length: 2 }
  validates :phone_number, presence: true

  belongs_to :user
  belongs_to :event
end
