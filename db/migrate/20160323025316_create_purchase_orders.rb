class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.belongs_to :work_detail, index: true, foreign_key: true
      t.decimal :quantity
      t.string :unit
      t.string :description
      t.decimal :unit_cost
      t.decimal :amount
      t.datetime :date

      t.timestamps null: false
    end
  end
end
