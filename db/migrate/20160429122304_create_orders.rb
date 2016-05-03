class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :customer_type

      t.timestamps null: false
    end
    add_index :orders, :customer_id
    add_index :orders, :customer_type
  end
end
