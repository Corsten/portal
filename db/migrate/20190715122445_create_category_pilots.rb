class CreateCategoryPilots < ActiveRecord::Migration[5.2]
  def change
    create_table :category_pilots do |t|
      t.belongs_to :group
      t.string :customer_name
      t.string :supplier_name
      t.string :software_name
      t.string :manufacturer_name

      t.boolean :in_rsr, default: false
      t.string :registry_link
      t.string :leader_state

      t.string :unfunctional_requirements
      t.string :functional_requirements

      t.string :notes
      t.string :manufacturer_link
      t.string :customer_link

      t.timestamps
    end
  end
end
