class CreateCategoryPilotImports < ActiveRecord::Migration[5.2]
  def change
    create_table :category_pilot_imports do |t|
      t.string :notes
      t.oid :document_store
      t.string :document_content_type
      t.string :document_original_filename

      t.timestamps
    end
  end
end
