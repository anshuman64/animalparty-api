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

ActiveRecord::Schema.define(version: 20180511233637) do

  create_table "connections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "blue_id", null: false
    t.integer "red_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blue_id"], name: "index_connections_on_blue_id"
    t.index ["red_id"], name: "index_connections_on_red_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "phone_number"
    t.string "email"
    t.string "political_party"
    t.string "firebase_uid", null: false
    t.boolean "is_banned", default: false, null: false
    t.datetime "last_login", default: "2018-05-11 23:37:36", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "queued_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firebase_uid"], name: "index_users_on_firebase_uid", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

end
