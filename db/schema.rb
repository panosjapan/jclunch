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

ActiveRecord::Schema.define(:version => 20131106170330) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "one_lunch"
  end

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.time     "work_start_at"
    t.integer  "minute_step"
    t.string   "attendance"
  end

  create_table "holidays", :force => true do |t|
    t.integer  "user_id"
    t.date     "holiday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "menu_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menu_translations", :force => true do |t|
    t.integer  "menu_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "menu_translations", ["locale"], :name => "index_menu_translations_on_locale"
  add_index "menu_translations", ["menu_id"], :name => "index_menu_translations_on_menu_id"

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.decimal  "price",              :precision => 6, :scale => 2
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "category_id"
    t.string   "state"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
    t.string   "status"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "admin"
    t.integer  "department_id"
    t.string   "kind"
    t.decimal  "wage",                   :precision => 8, :scale => 2
    t.string   "ni_number"
    t.boolean  "holiday_request",                                      :default => false
  end

  create_table "work_records", :force => true do |t|
    t.string   "state"
    t.date     "work_on"
    t.time     "attend_at"
    t.time     "start_at"
    t.time     "end_at"
    t.time     "lunch_start_at"
    t.time     "lunch_end_at"
    t.time     "left_at"
    t.decimal  "wage",           :precision => 8, :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "approved_by"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

end
