# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120808082616) do

  create_table "categories", :force => true do |t|
    t.integer  "product_id"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "screen_name"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id"], :name => "category_id_ix"
  add_index "categories_products", ["product_id"], :name => "product_id_ix"

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.string   "product_type"
    t.string   "title"
    t.text     "summary"
    t.datetime "year"
    t.text     "director"
    t.string   "language"
    t.boolean  "new_release"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "trailer_url"
    t.boolean  "opportunity"
    t.boolean  "future_release"
    t.string   "actors"
    t.string   "initial"
    t.integer  "duration"
    t.decimal  "discount_price", :precision => 8, :scale => 2
    t.decimal  "normal_price",   :precision => 8, :scale => 2
    t.string   "imdb_score"
    t.string   "poster"
    t.boolean  "blue"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "hashed_password"
    t.datetime "last_subscription_visit"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "salt"
    t.string   "title_alpha"
    t.string   "title_beta"
    t.string   "title_omega"
  end

end
