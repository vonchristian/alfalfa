class Equipment < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:make_and_model]
  has_many :equipment_maintenances, class_name: "Maintenance"
  has_many :fuel_expenses, as: :inventoriable, class_name: "IssuedInventory"
  has_many :equipment_schedules
  def make_and_model
    "#{make} - #{model}"
  end

  def to_s
    make_and_model
  end


  private

  # def add_to_accounts
  #   Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.acquisition_cost), account: "Construction Equipment"],
  #                       credit_amounts_attributes:[amount: (self.acquisition_cost), account: "Owners Capital"])
  # end
end
