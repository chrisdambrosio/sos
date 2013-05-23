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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130523071207) do

  create_table "alerts", force: true do |t|
    t.string   "description"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_methods", force: true do |t|
    t.string   "label"
    t.string   "address"
    t.integer  "type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_methods", ["user_id"], name: "index_contact_methods_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "contact_method_id"
    t.integer  "alert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["alert_id"], name: "index_notifications_on_alert_id", using: :btree
  add_index "notifications", ["contact_method_id"], name: "index_notifications_on_contact_method_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
