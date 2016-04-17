class CreateRestockings < ActiveRecord::Migration
  def change
    create_table :restockings do |t|
      t.decimal :quantity
      t.decimal :price
      t.belongs_to :inventory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
