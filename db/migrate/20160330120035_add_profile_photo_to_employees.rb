class AddProfilePhotoToEmployees < ActiveRecord::Migration
  def up
    add_attachment :employees, :profile_photo
  end

  def down
    remove_attachment :employees, :profile_photo
  end
end
