class AddProfileImageToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :profile_image_id, :string
  end
end
