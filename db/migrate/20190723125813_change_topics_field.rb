class ChangeTopicsField < ActiveRecord::Migration[5.2]
  def up
    change_table :events, bulk: true do |t|
      t.remove :topics
      t.string :topics
    end
  end

  def down
    change_table :events, bulk: true do |t|
      t.remove :topics
      t.string :topics, array: true, default: []
    end
  end
end
