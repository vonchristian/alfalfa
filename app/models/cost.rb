class Cost < ActiveRecord::Base
  belongs_to :project

  def self.total
    all.sum(:total_cost)
  end
end
