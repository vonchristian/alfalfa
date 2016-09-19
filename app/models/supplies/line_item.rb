class Supplies::LineItem < ActiveRecord::Base
  attr_accessor :change_price

  belongs_to :inventory
  belongs_to :cart, class_name: "Supplies::Cart"
  belongs_to :order, class_name: "Supplies::Order"

  validates :quantity, numericality: {less_than_or_equal_to: :inventory_quantity }, on: :create

  delegate :paid?, :unpaid?, to: :order
  delegate :check_if_out_of_stock, to: :inventory
  validates :unit_cost, :presence => true

  def self.filter_with(hash={})
    if hash[:from_date] && hash[:to_date]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      self.where('date' => from_date..to_date)
    end
  end

  def total_price
    if unit_cost.nil?
      inventory.price * quantity
    else 
      unit_cost * quantity
    end
  end
  
  def set_date
    self.date = self.order.date_issued
    self.save
  end
  def set_total_cost
    self.total_cost = self.total_price
    self.save
  end

  def inventory_quantity
    inventory.quantity
  end

  def self.total_price
      self.all.to_a.sum { |item| item.total_price }
  end
end
