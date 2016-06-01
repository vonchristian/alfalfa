class Supplies::LineItem < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :cart, class_name: "Supplies::Cart"
  belongs_to :order, class_name: "Supplies::Order"

  validates :quantity, numericality: {less_than_or_equal_to: :inventory_quantity }, on: :create

  delegate :paid?, :unpaid?, to: :order
  delegate :check_if_out_of_stock, to: :inventory

  def total_price
      inventory.price * quantity
    end

    def inventory_quantity
      inventory.quantity
    end

    def self.total_price
        self.all.to_a.sum { |item| item.total_price }
    end
  end
