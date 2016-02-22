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

ActiveRecord::Schema.define(version: 20160221111014) do

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

  create_table "additional_informations", force: :cascade do |t|
    t.string   "sex"
    t.datetime "birth_date"
    t.string   "birth_place"
    t.string   "civil_status"
    t.string   "nationality"
    t.integer  "informeable_id"
    t.string   "informeable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "additional_informations", ["informeable_id"], name: "index_additional_informations_on_informeable_id", using: :btree
  add_index "additional_informations", ["user_id"], name: "index_additional_informations_on_user_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "sitio"
    t.string   "barangay"
    t.string   "municipality"
    t.string   "province"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "addresses", ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

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
    t.decimal  "purchase_price"
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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "depreciations", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "depreciationable_id"
    t.string   "depreciationable_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "depreciations", ["depreciationable_id"], name: "index_depreciations_on_depreciationable_id", using: :btree
  add_index "depreciations", ["depreciationable_type"], name: "index_depreciations_on_depreciationable_type", using: :btree

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "photo_id"
    t.integer  "position"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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

  create_table "equipment_costs", force: :cascade do |t|
    t.string   "equipment"
    t.decimal  "number_of_equipment"
    t.decimal  "number_of_days"
    t.decimal  "daily_rate"
    t.decimal  "total_cost"
    t.integer  "work_detail_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "equipment_costs", ["work_detail_id"], name: "index_equipment_costs_on_work_detail_id", using: :btree

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

  create_table "invoices", force: :cascade do |t|
    t.string   "amount"
    t.integer  "invoiceable_id"
    t.string   "invoiceable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "invoices", ["invoiceable_id"], name: "index_invoices_on_invoiceable_id", using: :btree
  add_index "invoices", ["invoiceable_type"], name: "index_invoices_on_invoiceable_type", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "division_id"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["division_id"], name: "index_items_on_division_id", using: :btree

  create_table "labor_costs", force: :cascade do |t|
    t.string   "personnel"
    t.decimal  "number_of_personnel"
    t.decimal  "number_of_days"
    t.decimal  "daily_rate"
    t.decimal  "total_cost"
    t.integer  "work_detail_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "labor_costs", ["work_detail_id"], name: "index_labor_costs_on_work_detail_id", using: :btree

  create_table "lands", force: :cascade do |t|
    t.decimal  "cost"
    t.integer  "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.string   "unit"
    t.decimal  "quantity"
    t.decimal  "unit_cost"
    t.decimal  "total_cost"
    t.integer  "work_detail_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "materials", ["work_detail_id"], name: "index_materials_on_work_detail_id", using: :btree

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
    t.integer  "project_type"
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
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "role"
    t.string   "profile_photo_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_accomplishments", force: :cascade do |t|
    t.decimal  "quantity"
    t.integer  "work_detail_id"
    t.datetime "date_accomplished"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "work_accomplishments", ["work_detail_id"], name: "index_work_accomplishments_on_work_detail_id", using: :btree

  create_table "work_details", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "code"
    t.string   "description"
    t.decimal  "quantity"
    t.string   "unit"
    t.decimal  "total_cost"
    t.decimal  "unit_cost"
    t.boolean  "accomplished"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "work_details", ["project_id"], name: "index_work_details_on_project_id", using: :btree

  create_table "workers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "mobile_number"
    t.string   "sex"
    t.date     "birth_date"
    t.string   "email"
    t.integer  "position"
    t.string   "photo_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "project_id"
  end

  add_index "workers", ["project_id"], name: "index_workers_on_project_id", using: :btree

  add_foreign_key "accomplishments", "projects"
  add_foreign_key "additional_informations", "users"
  add_foreign_key "addresses", "users"
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
  add_foreign_key "equipment_costs", "work_details"
  add_foreign_key "items", "divisions"
  add_foreign_key "labor_costs", "work_details"
  add_foreign_key "materials", "work_details"
  add_foreign_key "notice_to_proceeds", "projects"
  add_foreign_key "project_billings", "billings"
  add_foreign_key "project_billings", "contractors"
  add_foreign_key "project_billings", "projects"
  add_foreign_key "remarks", "projects"
  add_foreign_key "requirements", "bids"
  add_foreign_key "requirements", "documents"
  add_foreign_key "time_extensions", "projects"
  add_foreign_key "work_accomplishments", "work_details"
  add_foreign_key "work_details", "projects"
end
