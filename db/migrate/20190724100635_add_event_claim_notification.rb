class AddEventClaimNotification < ActiveRecord::Migration[5.2]
  def up
    change_table :administrators, bulk: true do |t|
      t.boolean :new_event_claim_notification, default: false
    end
  end

  def down
    change_table :administrators, bulk: true do |t|
      t.remove :new_event_claim_notification
    end
  end
end
