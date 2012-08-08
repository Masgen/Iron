class RenameImageToPosterInProducts < ActiveRecord::Migration
  def change
    rename_column :products, :image, :products
  end
end
