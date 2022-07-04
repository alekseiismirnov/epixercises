# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_03_205139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coordinators", force: :cascade do |t|
    t.string "name"
    t.string "contacts"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_coordinators_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "scores", default: 0
    t.integer "winner_id"
    t.integer "loser_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "order"
  end

  add_foreign_key "games", "teams", column: "loser_id"
  add_foreign_key "games", "teams", column: "winner_id"
  add_foreign_key "players", "teams"
end
