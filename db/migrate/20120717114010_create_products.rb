class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references    :category
      t.string        :type
      t.string        :title
      t.text          :summary
      t.float         :normal_price
      t.float         :discount_price
      t.integer       :year
      t.string        :director
      t.integer       :length
      t.string        :language
      t.boolean       :new_release

      t.timestamps
    end
  end
end
