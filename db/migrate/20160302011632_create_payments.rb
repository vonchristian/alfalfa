class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.integer :paymentable_id
      t.string :paymentable_type
      t.integer :payment_type
      t.datetime :date

      t.timestamps null: false
    end
    add_index :payments, :paymentable_id
    add_index :payments, :paymentable_type
  end
end
