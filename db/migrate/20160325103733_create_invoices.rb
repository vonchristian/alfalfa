class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.decimal :amount
      t.integer :invoiceable_id
      t.string :invoiceable_type
      t.datetime :date
      t.string :invoiced_to

      t.timestamps null: false
    end
    add_index :invoices, :invoiceable_id
    add_index :invoices, :invoiceable_type
  end
end
