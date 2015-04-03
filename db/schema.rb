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

ActiveRecord::Schema.define(:version => 20150403050613) do

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "vendor_codes", :force => true do |t|
    t.string   "code"
    t.string   "vendor"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "vendor_id"
    t.integer  "user_id"
    t.string   "instruction"
    t.string   "expiration"
    t.string   "help"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
