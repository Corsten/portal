module AdministratorRepository
  extend ActiveSupport::Concern

  included do
    scope :select_name_columns, -> { select(:id, :name, :surname, :patronymic) }
    scope :all_admins, -> { where(role: %i[admin]) }
    scope :new_users_notification_admins, -> { where(role: %i[admin], new_users_notification: true) }
    scope :new_pilots_notification_admins, -> { where(role: %i[admin], new_pilots_notification: true) }
    scope :new_testing_methods_notification_admins, -> { where(role: %i[admin], new_testing_methods_notification: true) }
    scope :new_event_claim_notification_admins, -> { where(role: %i[admin], new_event_claim_notification: true) }
  end
end
