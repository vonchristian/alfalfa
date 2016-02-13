class AmountRevision < ActiveRecord::Base
  validates :amount, numericality: {greater_than: 0}
  belongs_to :project
end
