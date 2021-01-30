class AddUserToCategoryTestingMethods < ActiveRecord::Migration[5.2]
  def change
    add_reference :category_testing_methods, :user, foreign_key: true
  end
end
