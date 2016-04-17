class AddAcquisitionDateToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :acquisition_date, :datetime
  end
end
