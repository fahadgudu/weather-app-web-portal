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

ActiveRecord::Schema.define(version: 20180116094925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_products", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "token"
    t.string   "postcode"
    t.string   "device_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "growing_guides", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "position"
  end

  create_table "growing_seasons", force: :cascade do |t|
    t.string   "season"
    t.text     "instructions"
    t.integer  "growing_guide_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "growing_seasons", ["growing_guide_id"], name: "index_growing_seasons_on_growing_guide_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.text     "detail"
    t.integer  "instructable_id"
    t.string   "instructable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "problem_solvers", force: :cascade do |t|
    t.string   "title"
    t.text     "problem"
    t.text     "resolution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
  end

  create_table "product_stores", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_stores", ["product_id"], name: "index_product_stores_on_product_id", using: :btree
  add_index "product_stores", ["store_id"], name: "index_product_stores_on_store_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.text     "description"
    t.string   "title"
    t.integer  "category_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "amount_needed",      default: 0.0
    t.integer  "product_type"
    t.integer  "product_size"
    t.integer  "position"
    t.integer  "calculator_type",    default: 0
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.text     "description"
    t.integer  "product_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.text     "call_to_action"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "recommended_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "recommendable_id"
    t.string   "recommendable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.integer  "company_id"
    t.string   "places_id"
    t.string   "fax"
    t.string   "state"
    t.string   "email"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "usages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "usages", ["product_id"], name: "index_usages_on_product_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "weather_update_id"
    t.string   "device_token",      default: ""
  end

  create_table "video_playlists", force: :cascade do |t|
    t.string   "title"
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.string   "youtube_playlist_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "weather_updates", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "after_four_hours"
    t.boolean  "daily"
    t.boolean  "weekly"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "weather_updates", ["user_id"], name: "index_weather_updates_on_user_id", using: :btree

  add_foreign_key "growing_seasons", "growing_guides"
  add_foreign_key "product_stores", "products"
  add_foreign_key "product_stores", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "usages", "products"
end
