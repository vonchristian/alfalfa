class AddPurposeToEquipmentSchedules < ActiveRecord::Migration
  def change
    add_column :equipment_schedules, :purpose, :text
  end
end
