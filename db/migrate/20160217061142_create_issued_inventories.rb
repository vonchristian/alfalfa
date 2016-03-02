class CreateIssuedInventories < ActiveRecord::Migration
  def change
    create_table :issued_inventories do |t|
      t.integer :inventoriable_id, index: true
      t.string :inventoriable_type, index: true
      t.string :code
      t.string :description
      t.string :unit
      t.decimal :quantity
      t.decimal :unit_cost
      t.decimal :total_cost
      t.integer :inventory_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
