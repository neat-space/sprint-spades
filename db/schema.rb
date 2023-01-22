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

ActiveRecord::Schema[7.0].define(version: 2023_01_22_074247) do
  create_table "game_rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_issue_id"
    t.index ["current_issue_id"], name: "index_game_rooms_on_current_issue_id"
    t.index ["user_id"], name: "index_game_rooms_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "game_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id"], name: "index_issues_on_game_room_id"
  end

  create_table "pokers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "story_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issue_id", null: false
    t.index ["issue_id"], name: "index_pokers_on_issue_id"
    t.index ["user_id"], name: "index_pokers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_rooms", "users"
  add_foreign_key "issues", "game_rooms"
  add_foreign_key "pokers", "issues"
  add_foreign_key "pokers", "users"
end
