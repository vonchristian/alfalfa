class Equipment < ActiveRecord::Base
  after_commit :add_to_accounts

  def make_and_model
    "#{make} - #{model}"
  end

  private

  def add_to_accounts
    Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.acquisition_cost), account: "Construction Equipment"],
                        credit_amounts_attributes:[amount: (self.acquisition_cost), account: "Owners Capital"])
  end
end
