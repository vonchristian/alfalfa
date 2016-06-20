class CreateEquipmentExpenses < ActiveRecord::Migration
  def change
    create_table :equipment_expenses do |t|
      t.text :description
      t.integer :entry_type
      t.datetime :date
      t.string :reference_number
      t.integer :entriable_id
      t.string :entriable_type

      t.timestamps null: false
    end
    add_index :equipment_expenses, :entriable_id
    add_index :equipment_expenses, :entriable_type
  end
end
