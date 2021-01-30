class AddStateResultColumns < ActiveRecord::Migration[5.2]
  def up
    change_table :category_pilots, bulk: true do |t|
      t.string :status
      t.string :result
    end
  end

  def down
    change_table :category_pilots, bulk: true do |t|
      t.remove :status
      t.remove :result
    end
  end
end
