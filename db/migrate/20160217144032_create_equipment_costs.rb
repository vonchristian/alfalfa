class CreateEquipmentCosts < ActiveRecord::Migration
  def change
    create_table :equipment_costs do |t|
      t.string :equipment
      t.decimal :number_of_equipment
      t.decimal :number_of_days
      t.decimal :daily_rate
      t.decimal :total_cost
      t.belongs_to :work_detail, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
