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

ActiveRecord::Schema[8.1].define(version: 2026_06_15_142209) do
  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.integer "flat_id", null: false
    t.date "start_date"
    t.integer "total_price"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["flat_id"], name: "index_bookings_on_flat_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "address"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.string "name"
    t.integer "price_by_night"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_flats_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_reviews_on_booking_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "flats"
  add_foreign_key "bookings", "users"
  add_foreign_key "flats", "users"
  add_foreign_key "reviews", "bookings"
end
