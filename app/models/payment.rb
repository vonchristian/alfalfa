class Payment < ActiveRecord::Base
  belongs_to :paymentable, polymorphic: true

def create_entry
  Plutus::Entry.create!(description: self.paymentable.name, debit_amounts_attributes:[amount: (self.amount), account: "Accrued Payroll"],
                         credit_amounts_attributes:[amount: (self.amount), account: "Petty Cash"])
end
end
