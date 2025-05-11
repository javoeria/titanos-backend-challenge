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

ActiveRecord::Schema[7.1].define(version: 2025_05_11_150415) do
  create_table "apps", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "availabilities", charset: "utf8mb4", force: :cascade do |t|
    t.string "market"
    t.bigint "app_id"
    t.string "content_type"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_availabilities_on_app_id"
    t.index ["content_type", "content_id"], name: "index_availabilities_on_content"
  end

  create_table "channel_programs", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.bigint "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_programs_on_channel_id"
  end

  create_table "channels", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episodes", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "number"
    t.integer "season_number"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.bigint "tv_show_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id"], name: "index_episodes_on_tv_show_id"
  end

  create_table "favorite_apps", charset: "utf8mb4", force: :cascade do |t|
    t.integer "position"
    t.bigint "user_id"
    t.bigint "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_favorite_apps_on_app_id"
    t.index ["user_id"], name: "index_favorite_apps_on_user_id"
  end

  create_table "favorite_programs", charset: "utf8mb4", force: :cascade do |t|
    t.integer "watched_time"
    t.bigint "user_id"
    t.bigint "channel_program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_favorite_programs_on_channel_program_id"
    t.index ["user_id"], name: "index_favorite_programs_on_user_id"
  end

  create_table "movies", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "channel_program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_schedules_on_channel_program_id"
  end

  create_table "seasons", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "number"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.bigint "tv_show_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "tv_shows", charset: "utf8mb4", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
