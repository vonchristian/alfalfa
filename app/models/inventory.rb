class Inventory < ActiveRecord::Base
   # after_create :add_to_accounts
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:name]
  has_many :issued_inventories, as: :inventoriable
  def current_inventory_quantity
    quantity
  end

  def to_s
    "#{name} - #{cost}"
  end

  def total_cost
    quantity * cost
  end
   def add_to_accounts
    Plutus::Entry.create!(description: self.name, debit_amounts_attributes:[amount: (self.total_cost), account: "Inventory"],
                        credit_amounts_attributes:[amount: (self.total_cost), account: "Cash"])
  end
end
