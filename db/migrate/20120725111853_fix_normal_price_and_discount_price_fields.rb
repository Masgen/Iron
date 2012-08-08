class FixNormalPriceAndDiscountPriceFields < ActiveRecord::Migration
  def up
    remove_column :products, :discount_price
    remove_column :products, :normal_price
    add_column    :products, :discount_price, :decimal, precision: 8, scale: 2
    add_column    :products, :normal_price, :decimal, precision: 8, scale: 2
  end

  def down
    add_column :products, :discount_price, :float
    add_column :products, :normal_price, :float
    remove_column :products, :discount_price
    remove_column :products, :normal_price
  end
end
