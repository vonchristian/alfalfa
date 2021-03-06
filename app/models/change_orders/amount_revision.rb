class ChangeOrders::AmountRevision < ActiveRecord::Base
  validates :amount, numericality: {greater_than: 1 }
  validates :quantity, numericality: {greater_than: 0.1 }
  validates :remarks,:amount, :quantity, presence: true
  validates :date, presence: true
  belongs_to :work_detail
  belongs_to :recorder, class_name: "User", foreign_key: 'user_id'

  enum revision_type:[:additive, :subtractive]
  def self.total
    self.additive.all.sum(:amount) -   self.subtractive.all.sum(:amount)
  end
end
