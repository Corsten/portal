class CreateCategoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :category_products do |t|
      t.belongs_to :group
      t.string :name
      t.string :manufacturer
      t.string :link

      t.string :document_link

      t.oid :document_store
      t.string :document_content_type
      t.string :document_original_filename

      t.timestamps
    end
  end
end
