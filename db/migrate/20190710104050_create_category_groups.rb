class CreateCategoryGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_groups do |t|
      t.belongs_to :category
      t.string :name

      t.timestamps
    end
  end
end
