class AddProfilePhotoToContractors < ActiveRecord::Migration
  def up
    add_attachment :contractors, :profile_photo
  end

  def down
    remove_attachment :contractors, :profile_photo
  end
end
