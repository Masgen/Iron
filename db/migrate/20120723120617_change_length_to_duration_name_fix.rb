class ChangeLengthToDurationNameFix < ActiveRecord::Migration
  def change
    add_column :products, :duration, :integer
  end
end
