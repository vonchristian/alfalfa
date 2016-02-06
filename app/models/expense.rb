class Expense < ActiveRecord::Base
  belongs_to :expensable, polymorphic: true
  after_create :add_to_accounts
  def add_to_accounts
    Plutus::Entry.create!(description: self.description, debit_amounts_attributes:[amount: (self.amount), account: "Cost Charged to Jobs"],
                        credit_amounts_attributes:[amount: (self.amount), account: "Cash"])
                      end
end
