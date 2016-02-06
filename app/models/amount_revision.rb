class AmountRevision < ActiveRecord::Base
  validates :revised_contract_amount, numericality: {greater_than: :project_cost}
  belongs_to :project
 def project_cost
  self.project.cost 
end
end
