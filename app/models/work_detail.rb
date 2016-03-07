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
  has_many :equipment_costs, class_name: "WorkDetailCosts::EquipmentCost"
  has_many :miscellaneous_costs, class_name: "WorkDetailCosts::MiscellaneousCost"
  has_many :subcontract_costs, class_name: "WorkDetailCosts::SubcontractCost"

  delegate :cost, to: :project, prefix: true

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
    (self.accomplished_quantity / self.quantity)  * 100
  end

  def weighted_percent
    (total_cost / project_cost) * 100
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
end
