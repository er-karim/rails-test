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

ActiveRecord::Schema.define(version: 2019_07_30_234025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.integer "reference"
    t.string "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "manager_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "reference"
    t.string "email"
    t.string "home_phone_number"
    t.string "mobile_phone_number"
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "updates", force: :cascade do |t|
    t.string "field"
    t.string "value"
    t.string "updatable_type"
    t.bigint "updatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field"], name: "index_updates_on_field"
    t.index ["updatable_id", "updatable_type", "field", "value"], name: "uniqueness_index", unique: true
    t.index ["updatable_type", "updatable_id"], name: "index_updates_on_updatable_type_and_updatable_id"
    t.index ["value"], name: "index_updates_on_value"
  end

end
