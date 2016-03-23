class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.decimal :quantity
      t.belongs_to :inventory, index: true, foreign_key: true
      t.decimal :amount
      t.datetime :date

      t.timestamps null: false
    end
  end
end
