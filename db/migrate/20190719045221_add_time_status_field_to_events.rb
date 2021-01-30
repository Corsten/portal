class AddTimeStatusFieldToEvents < ActiveRecord::Migration[5.2]
  def up
    change_table :events, bulk: true do |t|
      t.remove :datetime
      t.datetime :date
      t.datetime :time
      t.string :state
    end
  end

  def down
    change_table :events, bulk: true do |t|
      t.remove :date
      t.remove :time
      t.remove :state
      t.datetime :datetime
    end
  end
end
