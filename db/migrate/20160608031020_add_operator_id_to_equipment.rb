class AddOperatorIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :employee_id, :integer
    add_index :equipment, :employee_id
  end
end
