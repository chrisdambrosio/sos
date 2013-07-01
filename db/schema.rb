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

ActiveRecord::Schema.define(version: 20130701221400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: true do |t|
    t.string   "description"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "assigned_to"
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

  create_table "log_entries", force: true do |t|
    t.integer  "alert_id"
    t.string   "action"
    t.integer  "subjectable_id"
    t.string   "subjectable_type"
    t.integer  "objectable_id"
    t.string   "objectable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "log_entries", ["alert_id"], name: "index_log_entries_on_alert_id", using: :btree

  create_table "notification_rules", force: true do |t|
    t.integer  "contact_method_id"
    t.integer  "start_delay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_rules", ["contact_method_id"], name: "index_notification_rules_on_contact_method_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "contact_method_id"
    t.integer  "alert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "send_at"
  end

  add_index "notifications", ["alert_id"], name: "index_notifications_on_alert_id", using: :btree
  add_index "notifications", ["contact_method_id"], name: "index_notifications_on_contact_method_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
