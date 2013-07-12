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

ActiveRecord::Schema.define(version: 20130712095539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: true do |t|
    t.string   "description"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_to"
    t.integer  "status"
  end

  add_index "alerts", ["status"], name: "index_alerts_on_status", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "channel"
    t.integer  "user_id"
    t.integer  "agent_id"
    t.string   "agent_type"
    t.integer  "notification_id"
  end

  add_index "log_entries", ["alert_id"], name: "index_log_entries_on_alert_id", using: :btree
  add_index "log_entries", ["notification_id"], name: "index_log_entries_on_notification_id", using: :btree
  add_index "log_entries", ["user_id"], name: "index_log_entries_on_user_id", using: :btree

  create_table "notification_rules", force: true do |t|
    t.integer  "contact_method_id"
    t.integer  "start_delay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_rules", ["contact_method_id"], name: "index_notification_rules_on_contact_method_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "alert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "send_at"
    t.string   "contact_type"
    t.string   "address"
    t.integer  "user_id"
  end

  add_index "notifications", ["alert_id"], name: "index_notifications_on_alert_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "restrictions", force: true do |t|
    t.integer  "schedule_layer_id"
    t.integer  "start_day_of_week"
    t.integer  "end_day_of_week"
    t.integer  "start_time_of_day"
    t.integer  "end_time_of_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restrictions", ["schedule_layer_id"], name: "index_restrictions_on_schedule_layer_id", using: :btree

  create_table "schedule_layers", force: true do |t|
    t.integer  "priority"
    t.integer  "rotation_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "schedule_id"
  end

  add_index "schedule_layers", ["schedule_id"], name: "index_schedule_layers_on_schedule_id", using: :btree

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms_reply_tokens", force: true do |t|
    t.integer  "alert_id"
    t.integer  "user_id"
    t.integer  "acknowledge_code"
    t.integer  "resolve_code"
    t.string   "source_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms_reply_tokens", ["alert_id"], name: "index_sms_reply_tokens_on_alert_id", using: :btree
  add_index "sms_reply_tokens", ["user_id"], name: "index_sms_reply_tokens_on_user_id", using: :btree

  create_table "user_schedules", force: true do |t|
    t.integer  "user_id"
    t.integer  "position"
    t.integer  "schedule_layer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_schedules", ["schedule_layer_id"], name: "index_user_schedules_on_schedule_layer_id", using: :btree
  add_index "user_schedules", ["user_id"], name: "index_user_schedules_on_user_id", using: :btree

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
