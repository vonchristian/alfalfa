class ChangeOrders::AmountRevision < ActiveRecord::Base
  validates :amount, numericality: {greater_than: 1}
  validates :remarks,:amount, presence: true
  validates :date, presence: true
  belongs_to :work_detail

    def self.total
    self.all.sum(:amount)
  end
end
