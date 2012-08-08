class AddImdbScoreToProducts < ActiveRecord::Migration
  def change
    add_column :products, :imdb_score, :string
  end
end
