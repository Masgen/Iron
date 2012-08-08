class AddAssociationTableAndRemoveReferences < ActiveRecord::Migration
  def change
    create_table :categories_products, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end
  end
  
  def up
    remove_column :products, :category_id
    remove_column :categories, :product_id
  end

  def down
    add_column :products, :category_id, :integer
    add_column :categories, :product_id, :integer
  end
end
