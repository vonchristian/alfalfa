class Contract < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  belongs_to :project
  belongs_to :contractor

  validates :contractor_id, presence: true, uniqueness: {scope: :project, message: "Contractor is already added"}
  validates :amount_subcontracted, presence: true, numericality: {less_than: :remaining_uncontracted_amount }

  delegate :remaining_uncontracted_amount, to: :project
end
