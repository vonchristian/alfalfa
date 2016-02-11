class AmountRevision < ActiveRecord::Base
  validates :revised_contract_amount, numericality: {greater_than: 0}
  belongs_to :project
end
