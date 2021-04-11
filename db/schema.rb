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

ActiveRecord::Schema.define(version: 2021_04_09_183450) do

  create_table "acoounts", force: :cascade do |t|
    t.string "bank"
    t.integer "document"
    t.string "type_document"
    t.string "number_account"
    t.string "phone"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_acoounts_on_user_id"
  end

  create_table "balace_inquiries", force: :cascade do |t|
    t.decimal "debt", precision: 18, scale: 2
    t.string "avalaible_days"
    t.string "operator"
    t.string "cod_area"
    t.string "phone"
    t.string "status", default: "en proceso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "balances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "balance", precision: 18, scale: 2
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "names"
    t.string "phone"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cod_area"
    t.string "operator"
    t.string "type_payment"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.decimal "amount"
    t.string "bank_origin"
    t.string "method_payment"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "day_payment"
    t.integer "month_payment"
    t.integer "year_payment"
    t.string "bank_destinity"
    t.string "ref_payment"
    t.string "status", default: "Diferido"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "address"
    t.integer "document"
    t.string "type_document"
    t.string "phone"
    t.string "state"
    t.string "city"
    t.string "gender"
    t.string "age"
    t.datetime "date_of_birth"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "recharge_params", force: :cascade do |t|
    t.string "operadora"
    t.integer "amount_min"
    t.integer "amount_max"
    t.string "multiplos_amount_permit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recharges", force: :cascade do |t|
    t.string "operator"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone"
    t.string "cod_area"
    t.decimal "amount", precision: 18, scale: 2
    t.string "type_payment"
    t.string "status", default: "enviada"
    t.string "type_operation", default: "direct_recharge"
    t.integer "available_days"
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "acoounts", "users"
  add_foreign_key "balances", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "deposits", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recharges", "users"
end
