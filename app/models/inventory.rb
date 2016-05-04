class Inventory < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  pg_search_scope :search_by_name, :against => :name
  has_many :issued_inventories
  has_many :sales
  has_many :stocks
  has_many :line_items, class_name: 'Supplies::LineItem'
  has_many :orders, through: :line_items, class_name: 'Supplies::Order'
  accepts_nested_attributes_for :stocks

  def quantity
    stocks.all.sum(:quantity) - line_items.all.sum(:quantity)
  end

  def quantity_and_unit
    "#{quantity} #{unit}"
  end
  def out_of_stock?
    quantity.zero? || quantity.negative?
  end


  def total_issued_inventories
    IssuedInventory.where(inventory_id: self.id).sum(:quantity)
  end


  def self.types
    ["PurchasedInventory", "RawMaterial"]
  end

  def current_inventory_quantity
    quantity
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
