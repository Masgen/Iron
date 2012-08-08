class AddBlueToProducts < ActiveRecord::Migration
  def change
    add_column :products, :blue, :boolean
  end
end
