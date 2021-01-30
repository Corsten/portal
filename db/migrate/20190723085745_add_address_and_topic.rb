class AddAddressAndTopic < ActiveRecord::Migration[5.2]
  def up
    change_table :events, bulk: true do |t|
      t.string :topics, array: true, default: []
      t.string :address
    end
  end

  def down
    change_table :events, bulk: true do |t|
      t.remove :topics
      t.remove :address
    end
  end
end
