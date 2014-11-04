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

ActiveRecord::Schema.define(:version => 20141030203745) do

  create_table "controller_plugin_configs", :force => true do |t|
    t.integer  "scaler_config_id"
    t.string   "name"
    t.string   "plugin_type"
    t.text     "value"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "min_resource"
    t.string   "max_resource"
    t.boolean  "dry_run",          :default => false
  end

  create_table "input_plugin_configs", :force => true do |t|
    t.string   "name"
    t.string   "plugin_type"
    t.integer  "interval"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "hysteresis_period"
    t.integer  "controller_plugin_config_id"
  end

  create_table "plugin_config_items", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "input_plugin_config_id"
  end

  create_table "scaler_configs", :force => true do |t|
    t.string   "heroku_app_name"
    t.string   "heroku_api_key"
    t.boolean  "dry_run"
    t.integer  "interval"
    t.integer  "blackout"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "librato_email"
    t.string   "librato_api_key"
  end

end
