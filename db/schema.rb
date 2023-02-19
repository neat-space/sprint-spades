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

ActiveRecord::Schema[7.0].define(version: 2023_02_19_063506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "game_room_users", force: :cascade do |t|
    t.bigint "game_room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id", "user_id"], name: "index_game_room_users_on_game_room_id_and_user_id", unique: true
    t.index ["game_room_id"], name: "index_game_room_users_on_game_room_id"
    t.index ["user_id"], name: "index_game_room_users_on_user_id"
  end

  create_table "game_rooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_issue_id"
    t.string "token", null: false
    t.index ["current_issue_id"], name: "index_game_rooms_on_current_issue_id"
    t.index ["user_id"], name: "index_game_rooms_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "game_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "points_revealed_at"
    t.integer "pokers_count", default: 0, null: false
    t.float "average_story_points", default: 0.0, null: false
    t.index ["game_room_id"], name: "index_issues_on_game_room_id"
  end

  create_table "pokers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "story_points", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "issue_id", null: false
    t.index ["issue_id"], name: "index_pokers_on_issue_id"
    t.index ["user_id", "issue_id"], name: "index_pokers_on_user_id_and_issue_id", unique: true
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
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_room_users", "game_rooms"
  add_foreign_key "game_room_users", "users"
  add_foreign_key "game_rooms", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "issues", "game_rooms"
  add_foreign_key "pokers", "issues"
  add_foreign_key "pokers", "users"
end
