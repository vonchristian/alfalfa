class AddProfilePhotoToUsers < ActiveRecord::Migration
  def up
    add_attachment :users, :profile_photo
  end

  def down
    remove_attachment :users, :profile_photo
  end
end
