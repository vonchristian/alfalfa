class Sale < ActiveRecord::Base
  belongs_to :inventory

  def update_accounts
    Entry.create!(date: self.date, description: "Sale of #{self.quantity} #{self.inventory.unit} #{self.inventory.name}", debit_amounts_attributes:[amount: (self.amount), account: "Petty Cash"],
                        credit_amounts_attributes:[amount: (self.amount), account: "Inventory"])
  end

  def update_quantity_of_inventory_on_save
    self.inventory.update_attributes(:quantity => self.inventory.quantity - self.quantity)
  end

end
