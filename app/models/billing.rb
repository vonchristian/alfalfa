class Billing < ActiveRecord::Base
  belongs_to :project
  belongs_to :contractor
  belongs_to :inventory
  before_save :set_cost
  validates :quantity, numericality:{less_than: :current_inventory_quantity}
  after_commit :update_quantity_of_inventory
  delegate :current_inventory_quantity, to: :inventory
  
  
  
  private

  def update_quantity_of_inventory
    self.inventory.quantity -= self.quantity
    self.inventory.save
  end
  private
  def set_cost
    self.cost = self.quantity * self.inventory.cost
  end
end
