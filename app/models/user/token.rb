class User::Token < ApplicationRecord
  include User::TokenRepository
  extend Enumerize
  belongs_to :user

  KINDS = %w[restore_password confirm_email change_attrs].freeze
  enumerize :kind, in: KINDS

  validates :kind, :body, presence: true
end
