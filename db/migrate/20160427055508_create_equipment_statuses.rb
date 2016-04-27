class CreateEquipmentStatuses < ActiveRecord::Migration
  def change
    create_table :equipment_statuses do |t|
      t.integer :status
      t.text :description
      t.belongs_to :equipment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
