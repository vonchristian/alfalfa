class WorkAccomplishment < ActiveRecord::Base
  belongs_to :work_detail
  validates :quantity, numericality: { less_than_or_equal_to: :work_detail_quantity }
  delegate :quantity, to: :work_detail, prefix: true
end
