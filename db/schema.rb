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


ActiveRecord::Schema.define(version: 20160530091201) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishment_images", force: :cascade do |t|
    t.integer  "work_accomplishment_id"
    t.string   "caption"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "accomplishment_images", ["work_accomplishment_id"], name: "index_accomplishment_images_on_work_accomplishment_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.boolean  "contra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["code"], name: "index_accounts_on_code", using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", using: :btree
  add_index "accounts", ["type"], name: "index_accounts_on_type", using: :btree

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
    t.decimal  "amount"
    t.string   "remarks"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "date"
    t.integer  "work_detail_id"
    t.integer  "user_id"
    t.decimal  "quantity"
    t.integer  "revision_type"
  end

  add_index "amount_revisions", ["user_id"], name: "index_amount_revisions_on_user_id", using: :btree
  add_index "amount_revisions", ["work_detail_id"], name: "index_amount_revisions_on_work_detail_id", using: :btree

  create_table "amounts", force: :cascade do |t|
    t.string  "type"
    t.integer "account_id"
    t.integer "entry_id"
    t.decimal "amount",     precision: 20, scale: 10
  end

  add_index "amounts", ["account_id", "entry_id"], name: "index_amounts_on_account_id_and_entry_id", using: :btree
  add_index "amounts", ["entry_id", "account_id"], name: "index_amounts_on_entry_id_and_account_id", using: :btree
  add_index "amounts", ["type"], name: "index_amounts_on_type", using: :btree

  create_table "attachment_files", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "attachment_report_file_name"
    t.string   "attachment_report_content_type"
    t.integer  "attachment_report_file_size"
    t.datetime "attachment_report_updated_at"
  end

  add_index "attachment_files", ["project_id"], name: "index_attachment_files_on_project_id", using: :btree

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

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.boolean  "main_contractor",            default: false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "position"
    t.string   "profile_image_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size"
    t.datetime "profile_photo_updated_at"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "contractor_id"
    t.decimal  "amount_subcontracted"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "contracts", ["contractor_id"], name: "index_contracts_on_contractor_id", using: :btree
  add_index "contracts", ["project_id"], name: "index_contracts_on_project_id", using: :btree

  create_table "costs", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "type"
    t.string   "description"
    t.decimal  "quantity"
    t.string   "unit"
    t.decimal  "unit_cost"
    t.decimal  "total_cost"
    t.datetime "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "costs", ["project_id"], name: "index_costs_on_project_id", using: :btree

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

  create_table "educational_attainments", force: :cascade do |t|
    t.string   "degree"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "educational_attainments", ["employee_id"], name: "index_educational_attainments_on_employee_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "photo_id"
    t.integer  "position"
    t.decimal  "rate"
    t.integer  "project_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size"
    t.datetime "profile_photo_updated_at"
  end

  add_index "employees", ["project_id"], name: "index_employees_on_project_id", using: :btree

  create_table "employments", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "employee_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "work_detail_id"
  end

  add_index "employments", ["employee_id"], name: "index_employments_on_employee_id", using: :btree
  add_index "employments", ["project_id"], name: "index_employments_on_project_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.datetime "date"
    t.integer  "entriable_id"
    t.string   "entriable_type"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "reference_number"
    t.string   "type"
  end

  add_index "entries", ["entriable_id"], name: "index_entries_on_entriable_id", using: :btree
  add_index "entries", ["entriable_type"], name: "index_entries_on_entriable_type", using: :btree

  create_table "equipment", force: :cascade do |t|
    t.string   "plate_number"
    t.string   "make"
    t.string   "model"
    t.integer  "operator_id"
    t.integer  "project_id"
    t.integer  "status"
    t.decimal  "acquisition_cost"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "acquisition_date"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
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

  create_table "equipment_schedules", force: :cascade do |t|
    t.integer  "equipment_id"
    t.integer  "employee_id"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "purpose"
  end

  add_index "equipment_schedules", ["employee_id"], name: "index_equipment_schedules_on_employee_id", using: :btree
  add_index "equipment_schedules", ["equipment_id"], name: "index_equipment_schedules_on_equipment_id", using: :btree
  add_index "equipment_schedules", ["project_id"], name: "index_equipment_schedules_on_project_id", using: :btree

  create_table "equipment_statuses", force: :cascade do |t|
    t.integer  "status"
    t.text     "description"
    t.integer  "equipment_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "equipment_statuses", ["equipment_id"], name: "index_equipment_statuses_on_equipment_id", using: :btree

  create_table "file_attachments", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "date"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "attached_file_file_name"
    t.string   "attached_file_content_type"
    t.integer  "attached_file_file_size"
    t.datetime "attached_file_updated_at"
  end

  add_index "file_attachments", ["project_id"], name: "index_file_attachments_on_project_id", using: :btree

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
    t.string   "name"
    t.string   "description"
    t.string   "unit"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "type"
    t.decimal  "price"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "invoiceable_id"
    t.string   "invoiceable_type"
    t.datetime "date"
    t.string   "invoiced_to"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "invoices", ["invoiceable_id"], name: "index_invoices_on_invoiceable_id", using: :btree
  add_index "invoices", ["invoiceable_type"], name: "index_invoices_on_invoiceable_type", using: :btree

  create_table "issued_inventories", force: :cascade do |t|
    t.integer  "inventoriable_id"
    t.string   "inventoriable_type"
    t.string   "code"
    t.string   "description"
    t.string   "unit"
    t.decimal  "quantity"
    t.decimal  "unit_cost"
    t.decimal  "total_cost"
    t.integer  "inventory_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "date_issued"
    t.integer  "contractor_id"
    t.integer  "project_id"
    t.integer  "work_detail_id"
    t.integer  "equipment_id"
  end

  add_index "issued_inventories", ["inventoriable_id"], name: "index_issued_inventories_on_inventoriable_id", using: :btree
  add_index "issued_inventories", ["inventoriable_type"], name: "index_issued_inventories_on_inventoriable_type", using: :btree
  add_index "issued_inventories", ["inventory_id"], name: "index_issued_inventories_on_inventory_id", using: :btree

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

  create_table "line_items", force: :cascade do |t|
    t.integer  "inventory_id"
    t.integer  "cart_id"
    t.decimal  "quantity",     default: 1.0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "order_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["inventory_id"], name: "index_line_items_on_inventory_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree

  create_table "maintenances", force: :cascade do |t|
    t.integer  "equipment_id"
    t.date     "date"
    t.string   "description"
    t.decimal  "quantity"
    t.string   "unit"
    t.decimal  "amount"
    t.string   "remarks"
    t.integer  "employee_id"
    t.integer  "work_detail_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "maintenances", ["employee_id"], name: "index_maintenances_on_employee_id", using: :btree
  add_index "maintenances", ["equipment_id"], name: "index_maintenances_on_equipment_id", using: :btree
  add_index "maintenances", ["work_detail_id"], name: "index_maintenances_on_work_detail_id", using: :btree

  create_table "miscellaneous_costs", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount"
    t.integer  "work_detail_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "miscellaneous_costs", ["work_detail_id"], name: "index_miscellaneous_costs_on_work_detail_id", using: :btree

  create_table "notice_to_proceeds", force: :cascade do |t|
    t.datetime "date"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notice_to_proceeds", ["project_id"], name: "index_notice_to_proceeds_on_project_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "customer_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "payment_status", default: 1
    t.datetime "date_issued"
    t.integer  "project_id"
    t.string   "name"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["customer_type"], name: "index_orders_on_customer_type", using: :btree

  create_table "overtimes", force: :cascade do |t|
    t.integer  "employee_id"
    t.decimal  "number_of_hours"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "status",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "overtimes", ["employee_id"], name: "index_overtimes_on_employee_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "paymentable_id"
    t.string   "paymentable_type"
    t.integer  "payment_type"
    t.datetime "date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "payments", ["paymentable_id"], name: "index_payments_on_paymentable_id", using: :btree
  add_index "payments", ["paymentable_type"], name: "index_payments_on_paymentable_type", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "main_contractor_id"
    t.string   "id_number"
    t.string   "name"
    t.string   "address"
    t.string   "status"
    t.integer  "duration"
    t.decimal  "cost"
    t.integer  "category_id"
    t.string   "implementing_office"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "type"
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id", using: :btree
  add_index "projects", ["main_contractor_id"], name: "index_projects_on_main_contractor_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "project_id"
    t.decimal  "quantity"
    t.string   "unit"
    t.string   "description"
    t.decimal  "unit_cost"
    t.decimal  "amount"
    t.datetime "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "purchase_orders", ["project_id"], name: "index_purchase_orders_on_project_id", using: :btree

  create_table "remarks", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "content"
    t.integer  "remarker_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "remarks", ["project_id"], name: "index_remarks_on_project_id", using: :btree
  add_index "remarks", ["remarker_id"], name: "index_remarks_on_remarker_id", using: :btree

  create_table "restockings", force: :cascade do |t|
    t.decimal  "quantity"
    t.decimal  "price"
    t.integer  "inventory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "total_cost"
  end

  add_index "restockings", ["inventory_id"], name: "index_restockings_on_inventory_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.decimal  "quantity"
    t.integer  "inventory_id"
    t.decimal  "amount"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "recipient"
  end

  add_index "sales", ["inventory_id"], name: "index_sales_on_inventory_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "inventory_id"
    t.decimal  "quantity"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "stocks", ["inventory_id"], name: "index_stocks_on_inventory_id", using: :btree

  create_table "subcontract_costs", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "contractor_id"
    t.string   "quantity"
    t.integer  "work_detail_id"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subcontract_costs", ["contractor_id"], name: "index_subcontract_costs_on_contractor_id", using: :btree
  add_index "subcontract_costs", ["work_detail_id"], name: "index_subcontract_costs_on_work_detail_id", using: :btree

  create_table "time_extensions", force: :cascade do |t|
    t.integer  "number_of_days"
    t.string   "remarks"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "project_id"
  end

  add_index "time_extensions", ["project_id"], name: "index_time_extensions_on_project_id", using: :btree
  add_index "time_extensions", ["user_id"], name: "index_time_extensions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "role"
    t.string   "profile_photo_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size"
    t.datetime "profile_photo_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_accomplishments", force: :cascade do |t|
    t.text     "remarks"
    t.decimal  "quantity"
    t.integer  "work_detail_id"
    t.datetime "date_accomplished"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "payment_status"
    t.integer  "user_id"
  end

  add_index "work_accomplishments", ["user_id"], name: "index_work_accomplishments_on_user_id", using: :btree
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

  create_table "worked_days", force: :cascade do |t|
    t.decimal  "number_of_days"
    t.integer  "employee_id"
    t.integer  "project_id"
    t.integer  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "worked_days", ["employee_id"], name: "index_worked_days_on_employee_id", using: :btree
  add_index "worked_days", ["project_id"], name: "index_worked_days_on_project_id", using: :btree

  add_foreign_key "accomplishment_images", "work_accomplishments"
  add_foreign_key "attachment_files", "projects"
  add_foreign_key "billable_materials", "contractors"
  add_foreign_key "billable_materials", "inventories"
  add_foreign_key "billable_materials", "projects"
  add_foreign_key "collections", "projects"
  add_foreign_key "contract_amount_revisions", "contractors"
  add_foreign_key "contract_amount_revisions", "contracts"
  add_foreign_key "contracts", "contractors"
  add_foreign_key "contracts", "projects"
  add_foreign_key "costs", "projects"
  add_foreign_key "educational_attainments", "employees"
  add_foreign_key "employments", "employees"
  add_foreign_key "employments", "projects"
  add_foreign_key "equipment", "projects"
  add_foreign_key "equipment_costs", "work_details"
  add_foreign_key "equipment_schedules", "employees"
  add_foreign_key "equipment_schedules", "equipment"
  add_foreign_key "equipment_schedules", "projects"
  add_foreign_key "equipment_statuses", "equipment"
  add_foreign_key "file_attachments", "projects"
  add_foreign_key "labor_costs", "work_details"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "inventories"
  add_foreign_key "maintenances", "employees"
  add_foreign_key "maintenances", "equipment"
  add_foreign_key "maintenances", "work_details"
  add_foreign_key "miscellaneous_costs", "work_details"
  add_foreign_key "notice_to_proceeds", "projects"
  add_foreign_key "overtimes", "employees"
  add_foreign_key "purchase_orders", "work_details", column: "project_id"
  add_foreign_key "remarks", "projects"
  add_foreign_key "restockings", "inventories"
  add_foreign_key "sales", "inventories"
  add_foreign_key "stocks", "inventories"
  add_foreign_key "subcontract_costs", "contractors"
  add_foreign_key "subcontract_costs", "work_details"
  add_foreign_key "work_accomplishments", "work_details"
  add_foreign_key "work_details", "projects"
  add_foreign_key "worked_days", "employees"
  add_foreign_key "worked_days", "projects"
end
