class AddTitleAlphaAndTitleBetaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title_alpha, :string
    add_column :users, :title_beta, :string
  end
end
