class WorkDetail < ActiveRecord::Base

include PublicActivity::Common
include PgSearch
  multisearchable :against => [:description]
  INDIRECT_COST_PERCENTAGE= BigDecimal('0.1550')
  VAT = BigDecimal('0.05')


  validates :quantity, numericality: {greater_than: 0.1}, presence: true
  belongs_to :project
  validates :code, :description, presence: true, uniqueness: {scope: :project}
  has_many :issued_inventories, as: :inventoriable
  has_many :labor_costs, class_name: "WorkDetailCosts::LaborCost"
  has_many :equipment_costs, class_name: "WorkDetailCosts::EquipmentCost"
  has_many :work_accomplishments
  has_many :miscellaneous_costs
  delegate :cost, to: :project, prefix: true
def name
  description
end
def slippage
  if work_accomplishments.present?
  actual_accomplishment_percent - target_accomplishment_percent
else
  0
end
end
def target_accomplishment_percent
      if project.notice_to_proceed.present?
       ((project.days_elapsed / project.duration.to_f) * 100).round(2)
     else
      0
     end
end
 def actual_accomplishment_percent
      if self.work_accomplishments.present?
        (self.work_accomplishments.sum(:quantity)/ self.quantity)  * 100
      else
        0
      end
    end

def weight_percent
  self.total_direct_cost / self.project_cost
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

def self.import(file)
    CSV.foreach(file.path, headers: true, :col_sep => ',') do |row|

      work_detail_hash = row.to_hash
        WorkDetail.create!(work_detail_hash)
    end
  end


end
