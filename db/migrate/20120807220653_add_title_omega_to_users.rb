class AddTitleOmegaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title_omega, :string
  end
end
