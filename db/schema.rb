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

ActiveRecord::Schema[7.0].define(version: 2022_06_14_120934) do
  create_table "loyalty_program_data", force: :cascade do |t|
    t.string "loyalty_program_id"
    t.decimal "points"
    t.text "transaction_history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "loyalty_programs" because of following StandardError
#   Unknown type 'duration' for column 'processing_time'

  create_table "transactions", force: :cascade do |t|
    t.string "loyalty_program_id"
    t.string "user_id"
    t.datetime "transaction_date"
    t.string "transactions_id"
    t.decimal "amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
