class PurchasedInventory < Inventory
    def update_accounts
    Plutus::Entry.create!(description: self.name, debit_amounts_attributes:[amount: (self.total_cost), account: "Inventory"],
                        credit_amounts_attributes:[amount: (self.total_cost), account: "Petty Cash"])
  end
end
