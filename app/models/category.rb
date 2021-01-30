class Category < ApplicationRecord
  include CategoryRepository

  validates :name, presence: true

  has_many :groups, dependent: :restrict_with_error

  accepts_nested_attributes_for :groups, reject_if: proc { |attributes| attributes['name'].blank? }
end
