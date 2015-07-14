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

ActiveRecord::Schema.define(version: 20150714133118) do

  create_table "articles", force: :cascade do |t|
    t.integer  "category_id",        limit: 2
    t.string   "title",              limit: 250
    t.string   "slug",               limit: 280
    t.text     "content",            limit: 65535
    t.string   "tags",               limit: 250
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.integer  "status",             limit: 1
    t.integer  "company_id",         limit: 4
    t.integer  "published_by",       limit: 4
    t.datetime "published_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "parent",      limit: 4
    t.string   "name",        limit: 150
    t.string   "slug",        limit: 180
    t.string   "description", limit: 250
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "member_type",        limit: 2
    t.string   "name",               limit: 180
    t.string   "slug",               limit: 200
    t.integer  "user_id",            limit: 4
    t.text     "website",            limit: 65535
    t.text     "description",        limit: 65535
    t.string   "fax",                limit: 100
    t.string   "phone",              limit: 100
    t.string   "email",              limit: 150
    t.string   "address",            limit: 300
    t.integer  "status",             limit: 1
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "first_name", limit: 150
    t.string   "last_name",  limit: 150
    t.string   "email",      limit: 180
    t.string   "phone",      limit: 100
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "category_id",        limit: 2
    t.string   "title",              limit: 250
    t.string   "slug",               limit: 280
    t.text     "content",            limit: 65535
    t.string   "tags",               limit: 250
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.integer  "status",             limit: 1
    t.integer  "company_id",         limit: 4
    t.integer  "published_by",       limit: 4
    t.datetime "published_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "company_id",   limit: 4
    t.string   "email",        limit: 150
    t.string   "password",     limit: 65
    t.string   "first_name",   limit: 50
    t.string   "last_name",    limit: 50
    t.string   "position",     limit: 75
    t.integer  "role",         limit: 1
    t.integer  "status",       limit: 1
    t.string   "recovery_uid", limit: 65
    t.datetime "recovery_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
