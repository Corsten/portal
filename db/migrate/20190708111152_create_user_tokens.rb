class CreateUserTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tokens do |t|
      t.string :body
      t.references :user, foreign_key: true
      t.string :kind

      t.timestamps
    end

    add_index :user_tokens, %i[kind body], unique: true
  end
end
