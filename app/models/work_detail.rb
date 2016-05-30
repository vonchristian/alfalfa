class WorkDetail < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch

  multisearchable :against => [:description]

  belongs_to :project
  has_many :work_accomplishments
  has_many :accomplishment_images, through: :work_accomplishments
  has_many :amount_revisions, class_name: "ChangeOrders::AmountRevision"

  validates :quantity, numericality: { greater_than: 0.1 }, presence: true
  validates :code, :description, presence: true, uniqueness: { scope: :project }
  validates :unit, presence: true

  delegate :cost, to: :project, prefix: true
  delegate :total, to: :amount_revisions, prefix: true

  def self.total
    self.all.sum(:total_cost)
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
