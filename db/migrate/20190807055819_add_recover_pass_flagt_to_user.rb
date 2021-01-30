class AddRecoverPassFlagtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :need_recover_pass, :boolean, default: false
  end
end
