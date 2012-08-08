class AddOpportunityAndFutureReleaseToProducts < ActiveRecord::Migration
  def change
    add_column :products, :opportunity, :boolean
    add_column :products, :future_release, :boolean
  end
end
