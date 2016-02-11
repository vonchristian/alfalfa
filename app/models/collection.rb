class Collection < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  after_commit :remaining_collection
 
  private
  def remaining_collection
    amount = self.project.revised_contract_amount - project.total_collection
  end
end
