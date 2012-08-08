class AddScreenNameToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :screen_name, :string
  end
end
