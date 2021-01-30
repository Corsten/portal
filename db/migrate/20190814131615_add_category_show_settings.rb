class AddCategoryShowSettings < ActiveRecord::Migration[5.2]
  def up
    change_table :categories, bulk: true do |t|
      t.boolean :enable_pilots, default: true
      t.boolean :enable_products, default: true
      t.boolean :enable_testing_methods, default: true
      t.boolean :enable_archives, default: true
    end
  end

  def down
    change_table :categories, bulk: true do |t|
      t.remove :enable_pilots
      t.remove :enable_products
      t.remove :enable_testing_methods
      t.remove :enable_archives
    end
  end
end
