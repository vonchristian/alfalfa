class Payment < ActiveRecord::Base
  belongs_to :paymentable, polymorphic: true

  after_commit :paid!

  delegate :paid!, to: :paymentable

def create_entry
  Entry.create!(entriable: self.paymentable, date: self.date, description: "Payment to #{paymentable.name}", debit_amounts_attributes:[amount: (self.amount), account: "Accrued Payroll"],
                         credit_amounts_attributes:[amount: (self.amount), account: "Petty Cash"])
end
end
