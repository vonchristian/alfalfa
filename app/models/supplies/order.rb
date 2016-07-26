class Supplies::Order < ActiveRecord::Base
  include PgSearch
  pg_search_scope :text_search, :against => [:date_issued, :customer_type]
  belongs_to :customer, polymorphic: true
  belongs_to :project
  enum pay_type:[:cash, :check]
  enum payment_status:[:paid, :unpaid]
  has_many :line_items, dependent: :destroy
  validates :date_issued, :customer_type, :customer_id,  presence: true

  def self.for_projects
    all.select{ |a| a.customer_type="Project" }
  end

  def self.for_contractors
    all.select{ |a| a.customer_type="Contractor" }
  end
  def self.for_equipment
    all.select{ |a| a.customer_type="Equipment" }
  end

  def self.filter_with(hash={})
    if hash[:from_date] && hash[:to_date] && hash[:customer_id]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      customer_id = hash[:customer_id] unless hash[:customer_id].blank?
      payment_status = hash[:payment_status] unless hash[:payment_status].blank?
      self.where('date_issued' => from_date..to_date).where('customer_id' => customer_id)
      # self.where('date' => from_date..to_date)
    elsif hash[:from_date] && hash[:to_date]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      self.where('date_issued' => from_date..to_date)
    else
      self.all
    end
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      item.check_if_out_of_stock
      item.set_total_cost
      item.set_date
    end
  end

  def self.select_customer_types
    ['Project', 'Contractor', 'Equipment']
  end
end
