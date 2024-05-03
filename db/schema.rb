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

ActiveRecord::Schema.define(version: 2024_05_03_021022) do

  create_table "balances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "balance", precision: 18, scale: 2, default: "0.0"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "nombres"
    t.string "apellidos"
    t.string "rif_o_cedula"
    t.string "direccion"
    t.string "telefono"
    t.string "estado_civil"
    t.string "email"
    t.string "ocupacion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "names"
    t.string "number"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cod_area"
    t.string "operator"
    t.string "type_payment"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "vehicle_id", null: false
    t.integer "insurance_plan_id", null: false
    t.integer "usage"
    t.integer "ramo"
    t.integer "coverage1"
    t.integer "coverage2"
    t.integer "coverage3"
    t.integer "year"
    t.string "placa"
    t.string "tipo"
    t.string "serial_carroceria"
    t.string "serial_motor"
    t.string "color"
    t.integer "puestos"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["insurance_plan_id"], name: "index_contracts_on_insurance_plan_id"
    t.index ["vehicle_id"], name: "index_contracts_on_vehicle_id"
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
    t.datetime "date_send"
    t.string "state", default: "ontried"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "insurance_plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.string "class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "news", force: :cascade do |t|
    t.string "link_news"
    t.string "link_img_news"
    t.string "etiqueta"
    t.string "subtitulo"
    t.datetime "date_news"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "nonexistent_numbers", force: :cascade do |t|
    t.string "operator"
    t.string "type_payment"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "zip_code"
    t.string "status", default: "incompleto"
    t.string "status_usuario", default: "activo"
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
    t.string "number"
    t.string "cod_area"
    t.decimal "amount", precision: 18, scale: 2
    t.string "type_payment"
    t.string "status", default: "enviada"
    t.integer "available_days"
    t.string "type_operation"
    t.decimal "saldo_resultante", precision: 18, scale: 2
    t.decimal "renta_mensual", precision: 18, scale: 2
    t.boolean "number_inexistente", default: false
    t.string "state", default: "ontried"
    t.string "user_phone"
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "system_configurations", force: :cascade do |t|
    t.boolean "movistar", default: false
    t.boolean "digitel", default: false
    t.boolean "movilnet", default: false
    t.boolean "cantv", default: false
    t.boolean "movistar_tv", default: false
    t.boolean "inter", default: false
    t.boolean "simple_tv", default: false
    t.decimal "dolar_bcv", precision: 18, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "usuarios_extras", default: 0
    t.integer "recargas_extras", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "permission_level", default: 1
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "user_referidor_id"
    t.string "referidor_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nombres"
    t.string "apellidos"
    t.string "rif_o_cedula"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "balances", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "insurance_plans"
  add_foreign_key "contracts", "vehicles"
  add_foreign_key "deposits", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recharges", "users"
end
