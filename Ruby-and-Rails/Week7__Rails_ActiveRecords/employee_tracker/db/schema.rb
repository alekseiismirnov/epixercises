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

ActiveRecord::Schema.define(version: 2022_07_13_153842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string "name"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.bigint "division_id"
    t.index ["division_id"], name: "index_employees_on_division_id"
  end

  create_table "employees_projects", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "project_id", null: false
    t.index ["employee_id"], name: "index_employees_projects_on_employee_id"
    t.index ["project_id"], name: "index_employees_projects_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
  end

end
