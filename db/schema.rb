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

ActiveRecord::Schema.define(version: 20150728004452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.string   "creator_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "event_id"
    t.string   "creator_name"
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "creator_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "name"
    t.string   "address"
    t.string   "time"
    t.string   "lat"
    t.string   "long"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "creator_name"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "creator_id"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "event_id"
    t.string   "creator_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.integer  "expires_at"
    t.string   "google_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
end
