class Cost < ActiveRecord::Base
  belongs_to :costable, polymorphic: true
  belongs_to :project

  validates :date, :total_cost, :description, :costable_id, :costable_type, presence: true

  def self.total
    all.sum(:total_cost)
  end
end
