module UserRepository
  extend ActiveSupport::Concern

  included do
    scope :by_downcase_email, ->(email) { where('lower(email) = ?', email&.downcase) }
  end
end
