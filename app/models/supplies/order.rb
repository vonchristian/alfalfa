class Supplies::Order < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  enum pay_type:[:cash, :check]
  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.customers
    ['Project', 'Contractor']
  end
end
