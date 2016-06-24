class AddEquipmentIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :equipment_id, :integer
    add_index :entries, :equipment_id
  end
end
