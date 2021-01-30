class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :kind
      t.datetime :document_date
      t.boolean :show_in_main_page

      t.string :document_link

      t.oid :document_store
      t.string :document_content_type
      t.string :document_original_filename

      t.timestamps
    end
  end
end
