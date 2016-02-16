class ConstructionEquipment < ActiveRecord::Base
  include PublicActivity::Common
  enum equipment_type:[:dump_truck, :excavator, :compressor, :other_construction_tools, :automobile, :pick_up_truck]
   has_many :images, as: :imageable, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true
  def make_and_model
  "#{make}  #{model} - (#{plate_number})"
  end

  def add_to_fixed_asset_accounts
  Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.purchase_price), account: "Construction Equipment"],
                         credit_amounts_attributes:[amount: (self.purchase_price), account: "Cash"])
  end

end
