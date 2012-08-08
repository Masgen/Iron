class AddActorsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :actors, :string
  end
end
