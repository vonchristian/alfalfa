class WorkDetailCosts::SubcontractCost < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :work_detail

  def self.total
    self.all.sum(:amount)
  end
end
