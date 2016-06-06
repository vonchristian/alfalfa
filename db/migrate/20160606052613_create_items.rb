class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.datetime :date
      t.string :reference_number
      t.decimal :quantity
      t.string :unit
      t.string :description
      t.string :unit_cost
      t.string :total_cost
      t.integer :itemable_id
      t.string :itemable_type

      t.timestamps null: false
    end
    add_index :items, :itemable_id
    add_index :items, :itemable_type
  end
end
