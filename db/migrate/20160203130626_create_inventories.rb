class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.decimal :cost
      t.integer :quantity
      t.string  :name
      t.string  :description
      t.string  :unit
      t.integer :status

      t.timestamps null: false
    end
  end
end
