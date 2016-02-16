class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :amount
      t.integer :invoiceable_id
      t.string :invoiceable_type

      t.timestamps null: false
    end
    add_index :invoices, :invoiceable_id
    add_index :invoices, :invoiceable_type
  end
end
