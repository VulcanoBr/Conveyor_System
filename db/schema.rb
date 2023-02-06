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

ActiveRecord::Schema[7.0].define(version: 2023_02_04_215059) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "start_distance"
    t.integer "final_distance"
    t.integer "deadline_hours"
    t.integer "mode_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_transport_id"], name: "index_deadlines_on_mode_transport_id"
  end

  create_table "delivery_orders", force: :cascade do |t|
    t.string "code"
    t.integer "deadline_hours"
    t.decimal "delivery_fee"
    t.decimal "km_price"
    t.decimal "amount"
    t.date "delivery_forecast"
    t.date "delivery_date"
    t.string "delivery_reason"
    t.integer "status", default: 0
    t.integer "closure_status"
    t.integer "order_id", null: false
    t.integer "mode_transport_id", null: false
    t.integer "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_transport_id"], name: "index_delivery_orders_on_mode_transport_id"
    t.index ["order_id"], name: "index_delivery_orders_on_order_id"
    t.index ["vehicle_id"], name: "index_delivery_orders_on_vehicle_id"
  end

  create_table "mode_transports", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.decimal "delivery_fee"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.string "product_code"
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.integer "weight"
    t.string "description"
    t.integer "distance"
    t.string "sender_name"
    t.integer "sender_identification"
    t.string "sender_email"
    t.string "sender_phone"
    t.string "sender_address"
    t.string "sender_city"
    t.string "sender_state"
    t.string "sender_zipcode"
    t.string "recipient_name"
    t.integer "recipient_identification"
    t.string "recipient_email"
    t.string "recipient_phone"
    t.string "recipient_address"
    t.string "recipient_city"
    t.string "recipient_state"
    t.string "recipient_zipcode"
    t.integer "status", default: 0
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "start_weight"
    t.integer "final_weight"
    t.decimal "km_price"
    t.integer "mode_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_transport_id"], name: "index_prices_on_mode_transport_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nameplate"
    t.string "brand"
    t.string "vehicle_model"
    t.integer "year_manufacture"
    t.integer "maximum_load"
    t.integer "status", default: 0
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_vehicles_on_category_id"
  end

  add_foreign_key "deadlines", "mode_transports"
  add_foreign_key "delivery_orders", "mode_transports"
  add_foreign_key "delivery_orders", "orders"
  add_foreign_key "delivery_orders", "vehicles"
  add_foreign_key "orders", "users"
  add_foreign_key "prices", "mode_transports"
  add_foreign_key "vehicles", "categories"
end
