class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :email
      t.string :state
      t.string :phone_number
      t.string :password_digest
      t.string :full_name
      t.string :organization
      t.string :position

      t.timestamps
    end
  end
end
