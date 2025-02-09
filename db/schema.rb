# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_29_171956) do
  create_table "tag_rules", force: :cascade do |t|
    t.integer "tag_id"
    t.string "search_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tag_rules_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "user_id"
    t.string "tag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "tag"], name: "index_tags_on_user_id_and_tag", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "transaction_tags", force: :cascade do |t|
    t.integer "user_transaction_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_transaction_tags_on_tag_id"
    t.index ["user_transaction_id"], name: "index_transaction_tags_on_user_transaction_id"
  end

  create_table "user_transactions", force: :cascade do |t|
    t.integer "user_id"
    t.date "transaction_date"
    t.string "description"
    t.decimal "debit", precision: 10, scale: 2
    t.decimal "credit", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
end
