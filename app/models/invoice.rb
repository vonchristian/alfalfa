class Invoice < ActiveRecord::Base
  belongs_to :invoiceable, polymorphic: true
  def update_accounts
  Plutus::Entry.create!(description: "Asset Depreciation", credit_amounts_attributes:[amount: (self.amount), account: "Accounts Payable-Trade"],
                         debit_amounts_attributes:[amount: (self.amount), account: "Current Period Net Income"])
  end
end
