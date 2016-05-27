class Equipment < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:make_and_model]
  has_many :orders, as: :customer, class_name: "Supplies::Order"
  has_many :line_items, through: :orders, class_name: "Supplies::LineItem"
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
                    default_url: ":style/equipment_icon.png",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  def make_and_model
    "#{make} - #{model}"
  end

  def current_assignment_id_number
    if equipment_schedules.present?
      equipment_schedules.last.project.id_number
    end
  end

  def current_assignment
    if equipment_schedules.present?
      equipment_schedules.last.project.name
    end
  end

  def current_assignment_location
    if equipment_schedules.present?
      equipment_schedules.last.project.address
    end
  end

  def current_assignment_purpose
    if equipment_schedules.present?
      equipment_schedules.last.purpose
    end
  end

  def current_assignment_start_date
    if equipment_schedules.last.start_date.present?
      equipment_schedules.last.start_date.strftime("%B %e, %Y")
    end
  end

  def current_assignment_end_date
    if equipment_schedules.last.end_date.present?
      equipment_schedules.last.end_date.strftime("%B %e, %Y")
    end
  end

  def current_assignment_operator
    if equipment_schedules.present?
      equipment_schedules.last.operator
    end
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

  def status
    if active?
      'success'
    elsif inactive?
      'warning'
    end
  end

  private

  # def add_to_accounts
  #   Plutus::Entry.create!(description: self.make_and_model, debit_amounts_attributes:[amount: (self.acquisition_cost), account: "Construction Equipment"],
  #                       credit_amounts_attributes:[amount: (self.acquisition_cost), account: "Owners Capital"])
  # end
end
