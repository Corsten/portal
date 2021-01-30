class AddRatingToCategoryProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :category_products, :rating, :string
  end
end
