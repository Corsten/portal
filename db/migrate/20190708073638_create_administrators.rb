class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :role
      t.string :email
      t.string :password_digest
      t.string :state

      t.string :surname
      t.string :name
      t.string :patronymic

      t.timestamps
    end

    add_index :administrators, :email, unique: true
  end
end
