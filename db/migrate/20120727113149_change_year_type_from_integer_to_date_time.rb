class ChangeYearTypeFromIntegerToDateTime < ActiveRecord::Migration
  def up
    change_column :products, :year, :datetime
  end

  def down
    change_column :products, :year, :integer
  end
end
