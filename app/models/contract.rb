class Contract < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  belongs_to :project
  belongs_to :contractor
  validates :contractor, presence: true
  validates :amount, numericality: true

  def update_accounts
  Plutus::Entry.create!(description: "Subcontracted Amount", debit_amounts_attributes:[amount: (self.amount), account: "Accounts Payable-Trade"],
                         credit_amounts_attributes:[amount: (self.amount), account: "Accounts Receivable-Trade"])
  end
end
