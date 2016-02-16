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

ActiveRecord::Schema.define(version: 20160216060815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishments", force: :cascade do |t|
    t.integer  "project_id"
    t.float    "percent"
    t.string   "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accomplishments", ["project_id"], name: "index_accomplishments_on_project_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "amount_revisions", force: :cascade do |t|
    t.integer  "project_id"
    t.decimal  "amount"
    t.string   "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "amount_revisions", ["project_id"], name: "index_amount_revisions_on_project_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "bidders_id"
    t.integer  "documents_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bids", ["project_id"], name: "index_bids_on_project_id", using: :btree

  create_table "billable_materials", force: :cascade do |t|
    t.integer  "contractor_id"
    t.integer  "inventory_id"
    t.decimal  "cost"
    t.integer  "reference_number"
    t.integer  "quantity"
    t.integer  "project_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "billable_materials", ["contractor_id"], name: "index_billable_materials_on_contractor_id", using: :btree
  add_index "billable_materials", ["inventory_id"], name: "index_billable_materials_on_inventory_id", using: :btree
  add_index "billable_materials", ["project_id"], name: "index_billable_materials_on_project_id", using: :btree

  create_table "billings", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "contractor_id"
    t.integer  "inventory_id"
    t.integer  "quantity"
    t.decimal  "cost"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "project_billing_id"
  end

  add_index "billings", ["contractor_id"], name: "index_billings_on_contractor_id", using: :btree
  add_index "billings", ["inventory_id"], name: "index_billings_on_inventory_id", using: :btree
  add_index "billings", ["project_billing_id"], name: "index_billings_on_project_billing_id", using: :btree
  add_index "billings", ["project_id"], name: "index_billings_on_project_id", using: :btree

  create_table "buildings", force: :cascade do |t|
    t.decimal  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_advances", force: :cascade do |t|
    t.integer  "cash_advanceable_id"
    t.string   "cash_advanceable_type"
    t.decimal  "amount"
    t.string   "purpose"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "cash_advances", ["cash_advanceable_id"], name: "index_cash_advances_on_cash_advanceable_id", using: :btree
  add_index "cash_advances", ["cash_advanceable_type"], name: "index_cash_advances_on_cash_advanceable_type", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.datetime "date"
    t.integer  "project_id"
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "collections", ["project_id"], name: "index_collections_on_project_id", using: :btree

  create_table "construction_equipments", force: :cascade do |t|
    t.string   "purchase_price"
    t.integer  "equipment_type"
    t.string   "make"
    t.string   "model"
    t.string   "plate_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "contract_amount_revisions", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "contractor_id"
    t.decimal  "amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "contract_amount_revisions", ["contract_id"], name: "index_contract_amount_revisions_on_contract_id", using: :btree
  add_index "contract_amount_revisions", ["contractor_id"], name: "index_contract_amount_revisions_on_contractor_id", using: :btree

  create_table "contractors", force: :cascade do |t|
    t.boolean  "main_contractor",  default: false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "position"
    t.string   "profile_image_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "contractor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.decimal  "amount"
  end

  add_index "contracts", ["contractor_id"], name: "index_contracts_on_contractor_id", using: :btree
  add_index "contracts", ["project_id"], name: "index_contracts_on_project_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "photo_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "position"
    t.integer  "project_id"
  end

  add_index "employees", ["project_id"], name: "index_employees_on_project_id", using: :btree

  create_table "equipment", force: :cascade do |t|
    t.string   "plate_number"
    t.string   "make"
    t.string   "model"
    t.integer  "operator_id"
    t.integer  "project_id"
    t.integer  "status"
    t.decimal  "acquisition_cost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "equipment", ["project_id"], name: "index_equipment_on_project_id", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "description"
    t.string   "received_by"
    t.string   "disbursed_by"
    t.datetime "date"
    t.integer  "expensable_id"
    t.string   "expensable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "expenses", ["expensable_id"], name: "index_expenses_on_expensable_id", using: :btree
  add_index "expenses", ["expensable_type"], name: "index_expenses_on_expensable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "file_id"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "images", ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
  add_index "images", ["imageable_type"], name: "index_images_on_imageable_type", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.decimal  "cost"
    t.integer  "quantity"
    t.string   "name"
    t.string   "description"
    t.string   "unit"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lands", force: :cascade do |t|
    t.decimal  "cost"
    t.integer  "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notice_to_proceeds", force: :cascade do |t|
    t.datetime "date"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notice_to_proceeds", ["project_id"], name: "index_notice_to_proceeds_on_project_id", using: :btree

  create_table "office_equipments", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "purchase_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "plutus_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "type"
    t.boolean  "contra"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plutus_accounts", ["name", "type"], name: "index_plutus_accounts_on_name_and_type", using: :btree

  create_table "plutus_amounts", force: :cascade do |t|
    t.string  "type"
    t.integer "account_id"
    t.integer "entry_id"
    t.decimal "amount",     precision: 20, scale: 10
  end

  add_index "plutus_amounts", ["account_id", "entry_id"], name: "index_plutus_amounts_on_account_id_and_entry_id", using: :btree
  add_index "plutus_amounts", ["entry_id", "account_id"], name: "index_plutus_amounts_on_entry_id_and_account_id", using: :btree
  add_index "plutus_amounts", ["type"], name: "index_plutus_amounts_on_type", using: :btree

  create_table "plutus_entries", force: :cascade do |t|
    t.string   "description"
    t.date     "date"
    t.integer  "commercial_document_id"
    t.string   "commercial_document_type"
    t.integer  "owner_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plutus_entries", ["commercial_document_id", "commercial_document_type"], name: "index_entries_on_commercial_doc", using: :btree
  add_index "plutus_entries", ["date"], name: "index_plutus_entries_on_date", using: :btree
  add_index "plutus_entries", ["owner_id"], name: "index_plutus_entries_on_owner_id", using: :btree
  add_index "plutus_entries", ["recipient_id"], name: "index_plutus_entries_on_recipient_id", using: :btree

  create_table "project_billings", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "billing_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "contractor_id"
  end

  add_index "project_billings", ["billing_id"], name: "index_project_billings_on_billing_id", using: :btree
  add_index "project_billings", ["contractor_id"], name: "index_project_billings_on_contractor_id", using: :btree
  add_index "project_billings", ["project_id"], name: "index_project_billings_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "main_contractor_id"
    t.string   "id_number"
    t.string   "name"
    t.string   "address"
    t.string   "status"
    t.integer  "duration"
    t.decimal  "cost"
    t.integer  "category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "implementing_office"
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id", using: :btree
  add_index "projects", ["main_contractor_id"], name: "index_projects_on_main_contractor_id", using: :btree

  create_table "remarks", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.integer  "remarker_id"
  end

  add_index "remarks", ["project_id"], name: "index_remarks_on_project_id", using: :btree

  create_table "requirements", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "document_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "requirements", ["bid_id"], name: "index_requirements_on_bid_id", using: :btree
  add_index "requirements", ["document_id"], name: "index_requirements_on_document_id", using: :btree

  create_table "time_extensions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "number_of_days"
    t.string   "remarks"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "time_extensions", ["project_id"], name: "index_time_extensions_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role"
    t.string   "profile_photo_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workers", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "workers", ["employee_id"], name: "index_workers_on_employee_id", using: :btree
  add_index "workers", ["project_id"], name: "index_workers_on_project_id", using: :btree

  add_foreign_key "accomplishments", "projects"
  add_foreign_key "amount_revisions", "projects"
  add_foreign_key "bids", "projects"
  add_foreign_key "billable_materials", "contractors"
  add_foreign_key "billable_materials", "inventories"
  add_foreign_key "billable_materials", "projects"
  add_foreign_key "billings", "contractors"
  add_foreign_key "billings", "inventories"
  add_foreign_key "billings", "project_billings"
  add_foreign_key "billings", "projects"
  add_foreign_key "collections", "projects"
  add_foreign_key "contract_amount_revisions", "contractors"
  add_foreign_key "contract_amount_revisions", "contracts"
  add_foreign_key "contracts", "contractors"
  add_foreign_key "contracts", "projects"
  add_foreign_key "equipment", "projects"
  add_foreign_key "notice_to_proceeds", "projects"
  add_foreign_key "project_billings", "billings"
  add_foreign_key "project_billings", "contractors"
  add_foreign_key "project_billings", "projects"
  add_foreign_key "remarks", "projects"
  add_foreign_key "requirements", "bids"
  add_foreign_key "requirements", "documents"
  add_foreign_key "time_extensions", "projects"
  add_foreign_key "workers", "employees"
  add_foreign_key "workers", "projects"
end
