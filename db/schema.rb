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

ActiveRecord::Schema.define(version: 20160512172143) do

  create_table "channels", force: :cascade do |t|
    t.string   "external_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["external_id"], name: "index_channels_on_external_id", unique: true
    t.index ["name"], name: "index_channels_on_name"
  end

  create_table "links", force: :cascade do |t|
    t.integer  "message_id"
    t.string   "url",         null: false
    t.string   "url_hash",    null: false
    t.string   "domain",      null: false
    t.string   "domain_hash", null: false
    t.string   "url_id",      null: false
    t.string   "url_id_hash", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["message_id"], name: "index_links_on_message_id"
    t.index ["url_hash"], name: "index_links_on_url_hash"
    t.index ["url_id_hash"], name: "index_links_on_url_id_hash"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "channel_id", null: false
    t.integer  "user_id",    null: false
    t.text     "body",       null: false
    t.string   "body_hash",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_hash"], name: "index_messages_on_body_hash"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "external_id",  null: false
    t.string   "name",         null: false
    t.string   "mention_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
    t.index ["mention_name"], name: "index_users_on_mention_name"
    t.index ["name"], name: "index_users_on_name"
  end

end
