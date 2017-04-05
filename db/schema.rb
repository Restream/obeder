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

ActiveRecord::Schema.define(version: 20170404135527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.string "dish_type"
  end

  create_table "menu_dishes", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "dish_id"
    t.boolean "default", default: false
    t.index ["dish_id"], name: "index_menu_dishes_on_dish_id", using: :btree
    t.index ["menu_id"], name: "index_menu_dishes_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.date    "date"
    t.boolean "ready",      default: false
    t.string  "aasm_state"
  end

  create_table "user_menu_dishes", force: :cascade do |t|
    t.integer "user_menu_id"
    t.integer "dish_id"
    t.index ["dish_id"], name: "index_user_menu_dishes_on_dish_id", using: :btree
    t.index ["user_menu_id", "dish_id"], name: "index_user_menu_dishes_on_user_menu_id_and_dish_id", unique: true, using: :btree
    t.index ["user_menu_id"], name: "index_user_menu_dishes_on_user_menu_id", using: :btree
  end

  create_table "user_menus", force: :cascade do |t|
    t.uuid    "user_id"
    t.integer "menu_id"
    t.text    "description"
    t.boolean "neem",        default: false
    t.boolean "editable",    default: true
    t.index ["menu_id"], name: "index_user_menus_on_menu_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.boolean "neem",            default: false
    t.string  "description"
    t.string  "password_digest"
    t.string  "role"
    t.string  "aasm_state"
  end

  add_foreign_key "menu_dishes", "dishes"
  add_foreign_key "menu_dishes", "menus"
  add_foreign_key "user_menu_dishes", "dishes"
  add_foreign_key "user_menu_dishes", "user_menus"
  add_foreign_key "user_menus", "menus"
  add_foreign_key "user_menus", "users"
end
