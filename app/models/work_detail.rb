class WorkDetail < ActiveRecord::Base
  INDIRECT_COST_PERCENTAGE= 0.1550
  VAT =  0.05
  belongs_to :project
  validates :code, :description, presence: true, uniqueness: true
  has_many :materials
  has_many :labor_costs
  has_many :equipment_costs
  accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true
  def total_direct_cost
    total_cost_of_materials + total_cost_of_labor + total_cost_of_equipment
  end

  def ocmp_mp
    total_cost * INDIRECT_COST_PERCENTAGE
  end

  def vat
    (total_direct_cost + ocmp_mp)
  end
  def total_cost_of_materials
    self.materials.sum(:total_cost) * VAT
  end

  def total_cost_of_equipment
    self.equipment_costs.sum(:total_cost)
  end

  def total_cost_of_labor
    self.labor_costs.sum(:total_cost)
  end
end
