class WorkDetailCosts::MiscellaneousCost < ActiveRecord::Base
  belongs_to :work_detail

  def self.total
    self.all.sum(:amount)
  end
end
