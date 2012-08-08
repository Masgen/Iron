class ChangeActorsTypeInProducts < ActiveRecord::Migration
  def up
    change_column :products, :director, :text
  end

  def down
    change_column :products, :director, :string
  end
end
