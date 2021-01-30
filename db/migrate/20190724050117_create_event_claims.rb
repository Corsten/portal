class CreateEventClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :event_claims do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :state

      t.timestamps
    end
  end
end
