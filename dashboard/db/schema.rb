# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2021_01_27_144141) do
  create_table "file_delta", force: :cascade do |t|
    t.string "filename"
    t.string "directory"
    t.datetime "event_time", precision: nil
    t.boolean "moved_from_flag"
    t.boolean "create_flag"
    t.boolean "delete_flag"
    t.boolean "modify_flag"
    t.integer "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_file_delta_on_host_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "hostname"
    t.string "ip"
    t.datetime "first_seen", precision: nil
    t.datetime "last_seen", precision: nil
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hosts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "file_delta", "hosts"
  add_foreign_key "hosts", "users"
end
