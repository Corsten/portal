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

ActiveRecord::Schema.define(version: 2019_08_14_131615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "role"
    t.string "email"
    t.string "password_digest"
    t.string "state"
    t.string "surname"
    t.string "name"
    t.string "patronymic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "new_pilots_notification", default: false
    t.boolean "new_users_notification", default: false
    t.boolean "new_testing_methods_notification", default: false
    t.boolean "new_event_claim_notification", default: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enable_pilots", default: true
    t.boolean "enable_products", default: true
    t.boolean "enable_testing_methods", default: true
    t.boolean "enable_archives", default: true
  end

  create_table "category_archives", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.string "customer_name"
    t.string "notes"
    t.string "document_link"
    t.oid "document_store"
    t.string "document_content_type"
    t.string "document_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_category_archives_on_group_id"
    t.index ["user_id"], name: "index_category_archives_on_user_id"
  end

  create_table "category_groups", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_groups_on_category_id"
  end

  create_table "category_pilot_imports", force: :cascade do |t|
    t.string "notes"
    t.oid "document_store"
    t.string "document_content_type"
    t.string "document_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_category_pilot_imports_on_user_id"
  end

  create_table "category_pilots", force: :cascade do |t|
    t.bigint "group_id"
    t.string "customer_name"
    t.string "supplier_name"
    t.string "software_name"
    t.string "manufacturer_name"
    t.boolean "in_rsr", default: false
    t.string "registry_link"
    t.string "leader_state"
    t.string "unfunctional_requirements"
    t.string "functional_requirements"
    t.string "notes"
    t.string "manufacturer_link"
    t.string "customer_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "result"
    t.index ["group_id"], name: "index_category_pilots_on_group_id"
  end

  create_table "category_products", force: :cascade do |t|
    t.bigint "group_id"
    t.string "name"
    t.string "manufacturer"
    t.string "link"
    t.string "document_link"
    t.oid "document_store"
    t.string "document_content_type"
    t.string "document_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rating"
    t.index ["group_id"], name: "index_category_products_on_group_id"
  end

  create_table "category_testing_methods", force: :cascade do |t|
    t.bigint "group_id"
    t.string "customer_name"
    t.string "notes"
    t.string "document_link"
    t.oid "document_store"
    t.string "document_content_type"
    t.string "document_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["group_id"], name: "index_category_testing_methods_on_group_id"
    t.index ["user_id"], name: "index_category_testing_methods_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "document_date"
    t.boolean "show_in_main_page"
    t.string "document_link"
    t.oid "document_store"
    t.string "document_content_type"
    t.string "document_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_claims", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_claims_on_event_id"
    t.index ["user_id"], name: "index_event_claims_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.string "description"
    t.datetime "date"
    t.datetime "time"
    t.string "state"
    t.string "address"
    t.string "topics"
    t.string "organizer"
  end

  create_table "user_tokens", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind", "body"], name: "index_user_tokens_on_kind_and_body", unique: true
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "surname"
    t.string "name"
    t.string "patronymic"
    t.string "email"
    t.string "state"
    t.string "phone_number"
    t.string "password_digest"
    t.string "full_name"
    t.boolean "confirmed_email", default: false
    t.string "organization"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "need_recover_pass", default: false
  end

  create_table "working_group_members", force: :cascade do |t|
    t.string "full_name"
    t.string "organization"
    t.string "position"
    t.oid "photo_store"
    t.string "photo_content_type"
    t.string "photo_original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_archives", "users"
  add_foreign_key "category_pilot_imports", "users"
  add_foreign_key "category_testing_methods", "users"
  add_foreign_key "event_claims", "events"
  add_foreign_key "event_claims", "users"
  add_foreign_key "user_tokens", "users"
end
