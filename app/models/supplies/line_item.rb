class Supplies::LineItem < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :cart, class_name: "Supplies::Cart"
  belongs_to :order, class_name: "Supplies::Order"

  validates :quantity, numericality: {less_than_or_equal_to: :inventory_quantity }
  delegate :quantity, to: :inventory, prefix: true
  delegate :paid?, :unpaid?, to: :order
  def total_price
      inventory.price * quantity
    end

    def self.total_price
        self.all.to_a.sum { |item| item.total_price }
    end
  end
