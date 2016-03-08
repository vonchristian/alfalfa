class ChangeOrders::AmountRevision < ActiveRecord::Base
  validates :amount, numericality: {greater_than: 1}
  validates :remarks,:amount, presence: true
  belongs_to :project
end
