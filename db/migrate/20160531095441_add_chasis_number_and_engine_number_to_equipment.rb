class AddChasisNumberAndEngineNumberToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :chassis_number, :string
    add_column :equipment, :engine_number, :string
  end
end
