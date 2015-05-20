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

ActiveRecord::Schema.define(version: 20150520065851) do

  create_table "banners", force: :cascade do |t|
    t.string   "imageable_type",     limit: 255
    t.integer  "imageable_id",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "growing_guides", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "growing_seasons", force: :cascade do |t|
    t.string   "season",           limit: 255
    t.text     "instructions",     limit: 65535
    t.integer  "growing_guide_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "growing_seasons", ["growing_guide_id"], name: "index_growing_seasons_on_growing_guide_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.text     "detail",            limit: 65535
    t.integer  "instructable_id",   limit: 4
    t.string   "instructable_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "problem_solvers", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "problem",    limit: 65535
    t.text     "resolution", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "product_stores", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "store_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "product_stores", ["product_id"], name: "index_product_stores_on_product_id", using: :btree
  add_index "product_stores", ["store_id"], name: "index_product_stores_on_store_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.text     "description",        limit: 65535
    t.string   "title",              limit: 255
    t.integer  "category_id",        limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "recommended_products", force: :cascade do |t|
    t.integer  "product_id",         limit: 4
    t.integer  "recommenable_id",    limit: 4
    t.string   "recommendable_type", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "postcode",   limit: 255
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "growing_seasons", "growing_guides"
  add_foreign_key "product_stores", "products"
  add_foreign_key "product_stores", "stores"
  add_foreign_key "products", "categories"
end
