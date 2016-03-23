class Sale < ActiveRecord::Base
  belongs_to :inventory
  after_commit :update_accounts
  def update_accounts
    Entry.create!(date: self.date, description: "Sale of #{self.quantity} #{self.inventory.unit} #{self.inventory.name}", debit_amounts_attributes:[amount: (self.amount), account: "Petty Cash"],
                        credit_amounts_attributes:[amount: (self.amount), account: "Inventory"])
  end


end
