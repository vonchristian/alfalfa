class IssuedInventory < ActiveRecord::Base
  belongs_to :inventoriable, polymorphic: true
  belongs_to :inventory
  delegate :cost, :name, to: :inventory, prefix: true
  validates :quantity, numericality: {less_than: :current_inventory_quantity, message: 'Quantity exceeded the current inventory quantity.'}
  validates :unit_cost, presence: true, numericality: true
  validates :inventory_id, presence: true
  validates :date_issued, presence: true
  delegate :current_inventory_quantity, to: :inventory

  def self.total
    self.all.sum(:total_cost)
  end

  def self.entered_on(hash={})
    if hash[:from_date] && hash[:to_date]
      from_date = hash[:from_date].kind_of?(Date) ? hash[:from_date] : DateTime.parse(hash[:from_date].strftime('%Y/%m/%d'))
      to_date = hash[:to_date].kind_of?(Date) ? hash[:to_date] : DateTime.parse(hash[:to_date].strftime('%Y/%m/%d'))
      IssuedInventory.where('created_at' => from_date..to_date)
    else
      IssuedInventory.all
    end
  end

  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
