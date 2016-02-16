class ContractAmountRevision < ActiveRecord::Base
  belongs_to :contract
  belongs_to :contractor
end
