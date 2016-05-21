module Supplies
  class Stock < ActiveRecord::Base
    belongs_to :inventory, class_name: "Supplies::Inventory"

    validates :date, :quantity, presence: true
    validates :quantity, numericality: { greater_than: 0.1 }
  end
end
