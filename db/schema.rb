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

ActiveRecord::Schema.define(version: 20170425145333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dictionaries", force: :cascade do |t|
    t.text     "word"
    t.text     "translation"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "language_id"
    t.integer  "category_id"
    t.integer  "user_id"
    t.index ["category_id"], name: "index_dictionaries_on_category_id", using: :btree
    t.index ["language_id"], name: "index_dictionaries_on_language_id", using: :btree
    t.index ["user_id"], name: "index_dictionaries_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "language_id"
    t.index ["language_id"], name: "index_groups_on_language_id", using: :btree
  end

  create_table "groups_members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_groups_members_on_group_id", using: :btree
    t.index ["user_id"], name: "index_groups_members_on_user_id", using: :btree
  end

  create_table "languages", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.datetime "last_login"
    t.text     "browser_type"
    t.text     "ip_address"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_logins_on_user_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_reports_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.text     "name"
    t.text     "email"
    t.text     "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "dictionaries", "categories"
  add_foreign_key "dictionaries", "languages"
  add_foreign_key "dictionaries", "users"
  add_foreign_key "groups", "languages"
  add_foreign_key "groups_members", "groups"
  add_foreign_key "groups_members", "users"
  add_foreign_key "logins", "users"
  add_foreign_key "reports", "users"
end
