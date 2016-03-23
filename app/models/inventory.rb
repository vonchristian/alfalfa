class Inventory < ActiveRecord::Base
   # after_create :add_to_accounts
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:name]
  has_many :issued_inventories, as: :inventoriable
  has_many :sales

  def self.types
    ["PurchasedInventory", "RawMaterial"]
  end

  def current_inventory_quantity
    quantity
  end

  def to_s
    "#{name} - #{cost}"
  end

  def total_cost
    quantity * cost
  end

end
