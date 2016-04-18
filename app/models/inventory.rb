class Inventory < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:name]
  has_many :issued_inventories
  has_many :restockings
  has_many :sales
  accepts_nested_attributes_for :restockings

  def remaining_quantity
    self.restockings.sum(:quantity) - self.total_issued_inventories - self.sales.sum(:quantity)
  end

  def total_issued_inventories
    IssuedInventory.where(inventory_id: self.id).sum(:quantity)
  end


  def self.types
    ["PurchasedInventory", "RawMaterial"]
  end

  def current_inventory_quantity
    remaining_quantity
  end

  def to_s
    "#{name} - #{description}"
  end

  def name_description
    "#{name} - #{description}"
  end

  def total_cost
    quantity * cost
  end

end
