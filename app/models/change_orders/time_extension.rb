class ChangeOrders::TimeExtension < ActiveRecord::Base
  validates :number_of_days, presence: true, numericality: { greater_than: 1 }
  validates :remarks, presence: true
  belongs_to :work_detail
end
