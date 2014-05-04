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

ActiveRecord::Schema.define(:version => 20140504105059) do

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",    :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "type"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_entries", :force => true do |t|
    t.integer  "order_id",                       :null => false
    t.integer  "product_cost_id",                :null => false
    t.integer  "quantity",        :default => 1
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "order_entries", ["order_id"], :name => "index_order_entries_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "customer_id", :null => false
    t.text     "address"
    t.text     "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"

  create_table "product_costs", :force => true do |t|
    t.integer  "cost"
    t.integer  "amount"
    t.integer  "weight",     :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.string  "title_en"
    t.string  "title_ru"
    t.text    "description_en"
    t.text    "description_ru"
    t.integer "section_id"
    t.integer "image_1_id"
    t.integer "image_2_id"
    t.integer "image_3_id"
    t.integer "image_4_id"
    t.integer "image_5_id"
    t.integer "cost_1_id",      :null => false
    t.integer "cost_2_id"
    t.integer "cost_3_id"
  end

  add_index "products", ["name"], :name => "index_products_on_name", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sections", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "title_ru"
    t.string   "title_en"
    t.integer  "weight",     :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "visible",    :default => true
    t.integer  "parent_id",  :default => 0
  end

  add_index "sections", ["name"], :name => "index_sections_on_name", :unique => true

  create_table "text_pages", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title_ru"
    t.string   "title_en"
    t.text     "body_ru"
    t.text     "body_en"
  end

  add_index "text_pages", ["name"], :name => "index_text_pages_on_name", :unique => true

end
