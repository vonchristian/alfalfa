class Land < ActiveRecord::Base
   def add_to_fixed_asset_accounts
  Plutus::Entry.create!(description: "Land Asset", debit_amounts_attributes:[amount: (self.cost), account: "Land"],
                         credit_amounts_attributes:[amount: (self.cost), account: "Cash"])
  end
end
