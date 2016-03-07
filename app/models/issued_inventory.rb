class IssuedInventory < ActiveRecord::Base
  belongs_to :inventoriable, polymorphic: true
  belongs_to :inventory
  delegate :cost, to: :inventory, prefix: true

  def self.total
    self.all.sum(:total_cost)
  end
end
