class Equipment < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:make_and_model]
  pg_search_scope :search_by_name, :against => [:make, :model, :plate_number]
  has_many :orders, as: :customer, class_name: "Supplies::Order"
  has_many :line_items, through: :orders, class_name: "Supplies::LineItem"
  has_many :items, as: :itemable
  has_many :equipment_schedules
  has_many :employees, through: :equipment_schedules
  delegate :full_name, to: :employee
  has_one :equipment_status
  has_attached_file :photo,
                    styles: { large: "120x120>",
                    medium: "70x70>",
                    thumb: "40x40>",
                    small: "30x30>",
                    x_small: "20x20>"},
                    default_url: "hero.jpg",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  def make_and_model
    "#{make} - #{model}"
  end

  def to_s
    make_and_model
  end

  def self.active
    all.select{|a| a.equipment_status.active? }
  end
  def self.inactive
    all.select{|a| a.equipment_status.inactive? }
  end

  def inactive?
      self.equipment_status && self.equipment_status.inactive?
  end

  def active?
      self.equipment_status && self.equipment_status.active?
  end

  def set_equipment_status
    EquipmentStatus.create(equipment_id: self.id, status: 0, description: "Ready")
  end

  private

  # def add_to_accounts
  #   Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.acquisition_cost), account: "Construction Equipment"],
  #                       credit_amounts_attributes:[amount: (self.acquisition_cost), account: "Owners Capital"])
  # end
end
