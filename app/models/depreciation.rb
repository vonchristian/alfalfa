class Depreciation < ActiveRecord::Base
  belongs_to :depreciationable, polymorphic: true


 def depreciate_asset
  Plutus::Entry.create!(description: "Asset Depreciation", debit_amounts_attributes:[amount: (self.amount), account: "Less Acc. Depreciation"],
                         credit_amounts_attributes:[amount: (self.amount), account: self.depreciationable_type.titleize])
  end
end
