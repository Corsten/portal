class CreateCategoryTestingMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :category_testing_methods do |t|
      t.belongs_to :group
      t.string :customer_name
      t.string :notes

      t.string :document_link

      t.oid :document_store
      t.string :document_content_type
      t.string :document_original_filename

      t.timestamps
    end
  end
end
