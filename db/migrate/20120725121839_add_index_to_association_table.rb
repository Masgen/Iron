class AddIndexToAssociationTable < ActiveRecord::Migration
  def change
    add_index :categories_products, :category_id, name: "category_id_ix"
    add_index :categories_products, :product_id, name: "product_id_ix"
  end
end
