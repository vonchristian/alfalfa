class Contract < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  belongs_to :project
  belongs_to :contractor
  has_many :payments, as: :entriable, class_name: "Accounting::Entry"

  validates :contractor_id, presence: true, uniqueness: {scope: :project, message: "Contractor is already added"}
  validates :amount_subcontracted, presence: true, numericality: {less_than_or_equal_to: :remaining_uncontracted_amount }

  delegate :remaining_uncontracted_amount, to: :project
end
