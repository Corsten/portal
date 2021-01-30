class AddNotificationsSettingsToAdministrators < ActiveRecord::Migration[5.2]
  def up
    change_table :administrators, bulk: true do |t|
      t.boolean :new_pilots_notification, default: false
      t.boolean :new_users_notification, default: false
      t.boolean :new_testing_methods_notification, default: false
    end
  end

  def down
    change_table :administrators, bulk: true do |t|
      t.remove :new_pilots_notification
      t.remove :new_users_notification
      t.remove :new_testing_methods_notification
    end
  end
end
