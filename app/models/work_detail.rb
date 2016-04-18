class WorkDetail < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch

  multisearchable :against => [:description]

  validates :quantity, numericality: {greater_than: 0.1}, presence: true
  validates :code, :description, presence: true, uniqueness: {scope: :project}
  validates :unit, presence: true

  belongs_to :project
  has_many :work_accomplishments
  has_many :issued_inventories, as: :inventoriable
  has_many :labor_costs, class_name: "WorkDetailCosts::LaborCost"
  has_many :equipment_maintenances, class_name: "Maintenance"
  has_many :miscellaneous_costs, class_name: "WorkDetailCosts::MiscellaneousCost"
  has_many :subcontract_costs, class_name: "WorkDetailCosts::SubcontractCost"
  has_many :purchase_orders
  has_many :equipment_costs, class_name: "EquipmentSchedule"
  has_many :equipment_fuel_costs,  as: :inventoriable, class_name: "IssuedInventory"

  delegate :cost, to: :project, prefix: true
  def equipment_fuelcosts
    IssuedInventory.where(inventoriable_id: self.id, inventory_id: Inventory.find_by_name("Fuel").id )
  end
  def material_costs
    IssuedInventory.where(inventoriable_id: self.id).where.not(inventory_id: Inventory.find_by_name("Fuel").id)
  end
  def self.total
    self.all.sum(:total_cost)
  end
  def total_quantity_approved_in_previous_billing
    if self.work_accomplishments.present?
      2
    else
      0
    end
  end
  def total_quantity_approved_in_this_billing
    self.work_accomplishments.unpaid.total * self.unit_cost
  end

  def balance_of_quantity
    self.quantity - self.work_accomplishments.paid.total
  end

  def cost_of_previous_billings
    self.total_quantity_approved_in_previous_billing * self.unit_cost
  end

  def cost_of_this_billing
    self.total_quantity_approved_in_this_billing * unit_cost
  end
  def cost_to_date
    self.cost_of_previous_billings + self.cost_of_this_billing
  end

  def balance_of_cost
    self.total_cost - self.cost_to_date
  end
  def equipment_costs_incurred
    self.equipment_fuelcosts.sum(:total_cost) + self.equipment_costs.sum(:total_cost)
  end
  def material_costs_incurred
    self.material_costs.sum(:total_cost)
  end
  def total_quantity_approved_in_previous_billing
    self.work_accomplishments.paid.sum(:quantity)
  end

  def quantity_approved_in_this_billing
    self.work_accomplishments.unpaid.sum(:quantity)
  end

  def total_quantity_to_this_date
    self.total_quantity_approved_in_previous_billing + self.quantity_approved_in_this_billing
  end

  def balance_of_quantity
    self.quantity - self.total_quantity_to_this_date
  end

  def cost_of_previous_billing
    self.total_quantity_approved_in_previous_billing * self.unit_cost
  end

  def cost_of_this_billing
    self.quantity_approved_in_this_billing * self.unit_cost
  end

  def cost_to_date
    self.cost_of_previous_billing + cost_of_this_billing
  end
  def balance_of_cost
    self.total_cost - self.cost_to_date
  end
  def name
    description
  end

  def slippage
    actual_accomplishment_percent - target_accomplishment_percent
  end

  def target_accomplishment_percent
     ((project.days_elapsed / project.duration.to_f) * 100).round(2)
  end

  def actual_accomplishment_percent
    (self.accomplished_quantity / self.quantity.to_f)  * 100
  end

  def remaining_accomplishment_percent
    if self.work_accomplishments.present?
      100 - actual_accomplishment_percent
    else
      0
    end
  end

  def weighted_percent
    ((total_cost / project_cost) * 100)
  end


  def actual_total_costs
    issued_inventories.total +
    labor_costs.total +
    equipment_costs.total +
    miscellaneous_costs.total +
    subcontract_costs.total
  end

  def profit
    total_cost - total_work_detail_costs
  end

  def accomplished_quantity
    work_accomplishments.total
  end

  def remaining_quantity
    quantity - accomplished_quantity
  end

  def set_status_to_accomplished
    if accomplished_quantity >= quantity
      update_column :accomplished, true
    end
  end

  def self.amount_to_be_collected
    self.all.map{|a| a.cost_of_this_billing}.sum
  end
end
