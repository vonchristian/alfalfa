class CreateOfficeEquipments < ActiveRecord::Migration
  def change
    create_table :office_equipments do |t|
      t.string :name
      t.string :description
      t.string :purchase_price

      t.timestamps null: false
    end
  end
end
