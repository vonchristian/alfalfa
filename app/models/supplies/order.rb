class Supplies::Order < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  belongs_to :project
  enum pay_type:[:cash, :check]
  enum payment_status:[:paid, :unpaid]
  has_many :line_items, dependent: :destroy

  def self.entered_on(hash={})
    if hash[:from_date] && hash[:to_date] && hash[:project_id]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      project = hash[:project_id]
      Supplies::Order.where('date_issued' => from_date..to_date).where('project_id' => project)
    elsif hash[:from_date] && hash[:to_date]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      Supplies::Order.where('date_issued' => from_date..to_date)
    else
      Supplies::Order.all
    end
  end
  
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
    Contractor.all  + Project.all
  end
  def self.projects
    Project.all
  end
end
