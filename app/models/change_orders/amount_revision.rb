class ChangeOrders::AmountRevision < ActiveRecord::Base
  validates :amount, numericality: {greater_than: 1}
  validates :remarks,:amount, presence: true
  validates :date, presence: true
  belongs_to :work_detail
  belongs_to :recorder, class_name: "User", foreign_key: 'user_id'

  def self.total
    self.all.sum(:amount)
  end
end
