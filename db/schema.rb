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

ActiveRecord::Schema.define(version: 20150414055506) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.date     "publish_date"
    t.string   "author",                limit: 255
    t.integer  "number_of_page",        limit: 4
    t.integer  "category_id",           limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "book_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favorites", ["book_id"], name: "index_favorites_on_book_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "activity_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "likes", ["activity_id"], name: "index_likes_on_activity_id", using: :btree
  add_index "likes", ["user_id", "activity_id"], name: "index_likes_on_user_id_and_activity_id", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "picture",    limit: 255
    t.integer  "book_id",    limit: 4
    t.integer  "request_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "pictures", ["book_id"], name: "index_pictures_on_book_id", using: :btree
  add_index "pictures", ["request_id"], name: "index_pictures_on_request_id", using: :btree

  create_table "read_statuses", force: :cascade do |t|
    t.string   "status",     limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "book_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "read_statuses", ["book_id"], name: "index_read_statuses_on_book_id", using: :btree
  add_index "read_statuses", ["user_id"], name: "index_read_statuses_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "content",    limit: 255
    t.string   "solve",      limit: 255, default: "pending"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "title",      limit: 255
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "books", "categories"
  add_foreign_key "favorites", "books"
  add_foreign_key "favorites", "users"
  add_foreign_key "likes", "activities"
  add_foreign_key "likes", "users"
  add_foreign_key "pictures", "books"
  add_foreign_key "pictures", "requests"
  add_foreign_key "read_statuses", "books"
  add_foreign_key "read_statuses", "users"
  add_foreign_key "requests", "users"
end
