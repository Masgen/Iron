class AddTrailerUrlToProducts < ActiveRecord::Migration
  def change
    add_column    :products, :trailer_url, :string, default: nil
  end
end
