module User::TokenRepository
  extend ActiveSupport::Concern

  included do
    scope :confirm_email, -> { where(kind: :confirm_email) }
    scope :change_attrs, -> { where(kind: :change_attrs) }
    scope :restore_password, -> { where(kind: :restore_password) }
    scope :with_expire_time, ->(time) { where('user_tokens.created_at > ?', Time.current - time) }
  end
end
