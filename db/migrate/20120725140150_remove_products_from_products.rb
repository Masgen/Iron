class RemoveProductsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :products
  end

  def down
    add_column :products, :products, :string
  end
end
