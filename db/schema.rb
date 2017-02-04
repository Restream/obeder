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

ActiveRecord::Schema.define(version: 20170204100217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.string "dish_type"
  end

  create_table "dishes_menus", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "dish_id"
    t.boolean "default"
    t.index ["dish_id"], name: "index_dishes_menus_on_dish_id", using: :btree
    t.index ["menu_id"], name: "index_dishes_menus_on_menu_id", using: :btree
  end

  create_table "dishes_menus_users", force: :cascade do |t|
    t.integer "menus_user_id"
    t.integer "dish_id"
    t.boolean "neem"
    t.index ["dish_id"], name: "index_dishes_menus_users_on_dish_id", using: :btree
    t.index ["menus_user_id"], name: "index_dishes_menus_users_on_menus_user_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.date    "date"
    t.boolean "ready"
  end

  create_table "menus_users", force: :cascade do |t|
    t.uuid    "user_id"
    t.integer "menu_id"
    t.index ["menu_id"], name: "index_menus_users_on_menu_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.boolean "neem"
    t.string  "description"
  end

  add_foreign_key "dishes_menus", "dishes"
  add_foreign_key "dishes_menus", "menus"
  add_foreign_key "dishes_menus_users", "dishes"
  add_foreign_key "dishes_menus_users", "menus_users"
  add_foreign_key "menus_users", "menus"
  add_foreign_key "menus_users", "users"
end
