class IssuedInventory < ActiveRecord::Base
  belongs_to :inventoriable, polymorphic: true
  belongs_to :inventory
  delegate :cost, :name, to: :inventory, prefix: true

  def self.total
    self.all.sum(:total_cost)
  end

  def update_quantity_of_inventory_on_save
    self.inventory.update_attributes(:quantity => self.inventory.quantity - self.quantity)
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
