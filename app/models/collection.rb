class Collection < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  def add_to_revenue
  Plutus::Entry.create!(description: "Revenue", debit_amounts_attributes:[amount: (self.amount), account: "Revenue"],
                         credit_amounts_attributes:[amount: (self.amount), account: "Accounts Payable-Trade"])
  end
end
