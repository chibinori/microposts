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

ActiveRecord::Schema.define(version: 20151126162257) do

  create_table "favariteposts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "favariteposts", ["micropost_id"], name: "index_favariteposts_on_micropost_id"
  add_index "favariteposts", ["user_id", "micropost_id"], name: "index_favariteposts_on_user_id_and_micropost_id", unique: true
  add_index "favariteposts", ["user_id"], name: "index_favariteposts_on_user_id"

  create_table "favoritepost_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "favoritepost_relationships", ["micropost_id"], name: "index_favoritepost_relationships_on_micropost_id"
  add_index "favoritepost_relationships", ["user_id", "micropost_id"], name: "index_favoritepost_relationships_on_user_id_and_micropost_id", unique: true
  add_index "favoritepost_relationships", ["user_id"], name: "index_favoritepost_relationships_on_user_id"

  create_table "favoriteposts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "favoriteposts", ["micropost_id"], name: "index_favoriteposts_on_micropost_id"
  add_index "favoriteposts", ["user_id", "micropost_id"], name: "index_favoriteposts_on_user_id_and_micropost_id", unique: true
  add_index "favoriteposts", ["user_id"], name: "index_favoriteposts_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "postimage"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "repost_relationships", force: :cascade do |t|
    t.integer  "reposting_id"
    t.integer  "reposted_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "repost_relationships", ["reposted_id"], name: "index_repost_relationships_on_reposted_id"
  add_index "repost_relationships", ["reposting_id", "reposted_id"], name: "index_repost_relationships_on_reposting_id_and_reposted_id", unique: true
  add_index "repost_relationships", ["reposting_id"], name: "index_repost_relationships_on_reposting_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.date     "birthday"
    t.string   "location"
    t.string   "biography"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
