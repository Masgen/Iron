class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :nickname
      t.string    :hashed_password
      t.datetime  :last_subscription_visit
      
      t.timestamps
    end
  end
end
