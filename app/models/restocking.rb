class Restocking < ActiveRecord::Base
  belongs_to :inventory
  after_commit :total_cost

  def total_cost
  	self.quantity * self.price
  end
end
