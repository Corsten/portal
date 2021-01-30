class Event < ApplicationRecord
  include EventRepository
  extend Enumerize

  has_many :claims, dependent: :destroy, class_name: 'Event::Claim'

  validates :name, presence: true
  validates :topics, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :organizer, presence: true
  validates :place, presence: true

  STATE = %i[scheduled completed].freeze

  enumerize :state, in: STATE

  validates :state, presence: true
end
