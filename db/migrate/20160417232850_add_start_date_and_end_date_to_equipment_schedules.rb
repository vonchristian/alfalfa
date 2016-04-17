class AddStartDateAndEndDateToEquipmentSchedules < ActiveRecord::Migration
  def change
    add_column :equipment_schedules, :start_date, :datetime
    add_column :equipment_schedules, :end_date, :datetime
  end
end
