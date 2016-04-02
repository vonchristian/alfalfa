class Category < ActiveRecord::Base

  def building?
    name == "Building"
  end
end
