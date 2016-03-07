class WorkDetailCosts::EquipmentCost < ActiveRecord::Base
  belongs_to :work_detail

  def self.total
    self.all.sum(:total_cost)
  end
end
