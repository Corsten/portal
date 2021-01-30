class CreateWorkingGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :working_group_members do |t|
      t.string :full_name
      t.string :organization
      t.string :position

      t.oid :photo_store
      t.string :photo_content_type
      t.string :photo_original_filename

      t.timestamps
    end
  end
end
