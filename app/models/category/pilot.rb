class Category::Pilot < ApplicationRecord
  extend Enumerize

  validates :customer_name, presence: true
  validates :software_name, presence: true

  validates :unfunctional_requirements, presence: true
  validates :functional_requirements, presence: true

  LEADER_STATE = %i[yes no unknown].freeze

  STATUS = %i[completed in_process implemented].freeze

  enumerize :leader_state, in: LEADER_STATE
  enumerize :status, in: STATUS

  validates :leader_state, presence: true
  validates :status, presence: true

  belongs_to :group
end
