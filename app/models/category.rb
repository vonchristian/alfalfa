class Category < ActiveRecord::Base
  attachment :photo, type: :image

  def building?
    name == "Building"
  end
end
