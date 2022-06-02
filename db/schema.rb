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

ActiveRecord::Schema[7.0].define(version: 2022_06_02_031817) do
  create_table "data_transfers", force: :cascade do |t|
    t.string "c4_acct_name"
    t.string "c4_token"
    t.string "c3_acct_name"
    t.string "c3_token"
    t.string "c3_url"
    t.integer "page"
    t.datetime "job_start_time", precision: nil
    t.datetime "job_end_time", precision: nil
    t.text "http_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transfer_data_type"
    t.string "status", limit: 100
    t.integer "user_id", limit: 100
  end

end
