class AddPosterColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :poster, :string
  end
end
