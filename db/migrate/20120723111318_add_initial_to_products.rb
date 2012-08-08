class AddInitialToProducts < ActiveRecord::Migration
  def change
    add_column :products, :initial, :string
  end
end
