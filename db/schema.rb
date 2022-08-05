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

ActiveRecord::Schema[7.0].define(version: 2022_08_05_003134) do
  create_table "account", force: :cascade do |t|
    t.integer "user_id"
    t.index ["user_id"], name: "index_account_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "loyalty_program_data", force: :cascade do |t|
    t.decimal "points", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.string "loyalty_program_id"
    t.index ["account_id"], name: "index_loyalty_program_data_on_account_id"
  end

  create_table "loyalty_programs", force: :cascade do |t|
    t.string "loyalty_program_id"
    t.string "program_name"
    t.string "currency_name"
    t.time "processing_time"
    t.text "description"
    t.string "enrollment_link"
    t.string "terms_and_conditions_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "loyalty_program_data_id"
    t.string "membership_regex"
    t.decimal "conversion_rate", default: "1.0", null: false
    t.index ["loyalty_program_data_id"], name: "index_loyalty_programs_on_loyalty_program_data_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount"
    t.integer "status", default: 0
    t.integer "account_id"
    t.integer "loyalty_program_datum_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "lastname"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account", "users"
  add_foreign_key "accounts", "users"
end
