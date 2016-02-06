class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :plate_number
      t.string :make
      t.string :model
      t.integer :operator_id
      t.belongs_to :project, index: true, foreign_key: true
      t.integer :status
      t.decimal :acquisition_cost
      t.timestamps null: false
    end
  end
end
