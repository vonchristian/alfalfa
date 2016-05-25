class AddPhotoToEquipment < ActiveRecord::Migration
  def up
    add_attachment :equipment, :photo
  end

  def down
    remove_attachment :equipment, :photo
  end
end
