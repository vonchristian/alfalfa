class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.belongs_to :inventory, index: true, foreign_key: true
      t.decimal :quantity
      t.datetime :date

      t.timestamps null: false
    end
  end
end
