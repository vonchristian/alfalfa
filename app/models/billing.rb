class Billing < ActiveRecord::Base
  belongs_to :project
  belongs_to :contractor
  belongs_to :inventory
  validates :quantity, numericality:{less_than: :current_inventory_quantity}
  after_commit :update_quantity_of_inventory
  delegate :current_inventory_quantity, to: :inventory

  def cost
    quantity * inventory.cost
  end
  
  private

  def update_quantity_of_inventory
    self.inventory.quantity -= self.quantity
    self.inventory.save
  end
end
