class Equipment < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:make_and_model]
  has_many :equipment_maintenances, class_name: "Maintenance"
  has_many :fuel_expenses, as: :inventoriable, class_name: "IssuedInventory"
  has_many :equipment_schedules
  has_many :employees, through: :equipment_schedules
  delegate :full_name, to: :employee
  has_one :equipment_status
  def make_and_model
    "#{make} - #{model}"
  end

  def to_s
    make_and_model
  end

  def set_equipment_status
    EquipmentStatus.create(equipment_id: self.id, status: 0, description: "Ready")
  end

  def inactive?
    self.equipment_status.inactive?
  end
  
  def active?
    self.equipment_status.active?
  end

  private

  # def add_to_accounts
  #   Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.acquisition_cost), account: "Construction Equipment"],
  #                       credit_amounts_attributes:[amount: (self.acquisition_cost), account: "Owners Capital"])
  # end
end
