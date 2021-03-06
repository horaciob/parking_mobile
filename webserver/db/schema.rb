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

ActiveRecord::Schema.define(version: 20150524152839) do

  create_table "cars", force: :cascade do |t|
    t.string   "license_plate", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "notification_token", limit: 500
    t.string   "user_agent",         limit: 255
    t.integer  "car_id",             limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "parkings", force: :cascade do |t|
    t.datetime "expires_at"
    t.string   "status",        limit: 255, default: "allowed"
    t.integer  "parking_units", limit: 4
    t.integer  "device_id",     limit: 4
    t.integer  "zone_id",       limit: 4
    t.integer  "car_id",        limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "payment_method", limit: 255
    t.string   "data",           limit: 255
    t.integer  "parking_id",     limit: 4
    t.integer  "device_id",      limit: 4
    t.string   "status",         limit: 255, default: "pending"
    t.float    "price",          limit: 24
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "number",     limit: 4
    t.float    "unit_price", limit: 24
    t.integer  "unit_time",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
