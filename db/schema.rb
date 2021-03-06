# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140723021135) do

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "rushee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["rushee_id", "created_at"], name: "index_comments_on_rushee_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "rushee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["rushee_id"], name: "index_relationships_on_rushee_id"
  add_index "relationships", ["user_id", "rushee_id"], name: "index_relationships_on_user_id_and_rushee_id", unique: true
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id"

  create_table "rushees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "preferred_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "hometown"
    t.string   "state"
    t.string   "high_school"
    t.string   "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "rushees", ["created_at"], name: "index_rushees_on_created_at"
  add_index "rushees", ["email"], name: "index_rushees_on_email"

  create_table "scores", force: true do |t|
    t.integer  "score",      default: 0
    t.integer  "rushee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["rushee_id"], name: "index_scores_on_rushee_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",              default: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
