class Stock < ActiveRecord::Base
  belongs_to :inventory, class_name: "Supplies::Inventory"
end
