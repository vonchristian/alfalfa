class CreateEquipmentSchedules < ActiveRecord::Migration
  def change
    create_table :equipment_schedules do |t|
      t.belongs_to :equipment, index: true, foreign_key: true
      t.belongs_to :work_detail, index: true, foreign_key: true
      t.decimal :number_of_hours
      t.decimal :rate
      t.decimal :total_cost

      t.timestamps null: false
    end
  end
end
