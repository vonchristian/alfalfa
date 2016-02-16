class CreateConstructionEquipments < ActiveRecord::Migration
  def change
    create_table :construction_equipments do |t|
      t.string :purchase_price
      t.integer :equipment_type
      t.string :make
      t.string :model
      t.string :plate_number

      t.timestamps null: false
    end
  end
end
