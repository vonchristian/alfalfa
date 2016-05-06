class Supplies::Order < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  enum pay_type:[:cash, :check]
  enum payment_status:[:paid, :unpaid]
  has_many :line_items, dependent: :destroy

  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.customer_types
    ['Project', 'Contractor', "Customer"]
  end
  def self.customers
    Project.all + Contractor.all
  end
end
