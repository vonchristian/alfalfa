class WorkDetail < ActiveRecord::Base
  INDIRECT_COST_PERCENTAGE= BigDecimal('0.1550')
  VAT = BigDecimal('0.05')


  validates :quantity, numericality: {greater_than: 0.1}, presence: true
  belongs_to :project
  validates :code, :description, presence: true, uniqueness: true
  has_many :materials
  has_many :labor_costs
  has_many :equipment_costs
  has_many :work_accomplishments
  accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true

def percent_of_work_detail_from_the_project_cost
  self.total_direct_cost / self.total_cost
end

  def total_quantity_accomplished
    self.work_accomplishments.sum(:quantity)
  end

  def total_direct_cost
    total_cost_of_materials + total_cost_of_labor + total_cost_of_equipment
  end

  def accomplished_quantity
    self.work_accomplishments.sum(:quantity)
  end

  def has_remaining_work?
    accomplished_quantity < quantity && !work_accomplishments.blank?
  end

  def remaining_quantity
    quantity - accomplished_quantity
  end

  def ocmp_mp
    total_cost * INDIRECT_COST_PERCENTAGE
  end

  def vat
    (total_direct_cost + ocmp_mp) * VAT
  end
  def total_cost_of_materials
    self.materials.sum(:total_cost)
  end

  def total_cost_of_equipment
    self.equipment_costs.sum(:total_cost)
  end

  def total_cost_of_labor
    self.labor_costs.sum(:total_cost)
  end
   def set_status
    if accomplished_quantity==quantity
      self.accomplished!
    end
  end

  def accomplished!
    update_column :accomplished, true
  end



end
