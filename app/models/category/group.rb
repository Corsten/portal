class Category::Group < ApplicationRecord
  validates :name, presence: true

  belongs_to :category

  has_many :products, dependent: :restrict_with_error, class_name: 'Category::Product'
  has_many :pilots, dependent: :restrict_with_error, class_name: 'Category::Pilot'
  has_many :testing_methods, dependent: :restrict_with_error, class_name: 'Category::TestingMethod'
  has_many :archives, dependent: :restrict_with_error, class_name: 'Category::Archive'
  validates :name, presence: true
end
