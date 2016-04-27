class Project < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:name, :id_number],
   :order_within_rank => "projects.created_at DESC"

  scope :joint_ventures, -> { where(type: 'JointVenture') }

  has_many :collections
  has_many :invoices, as: :invoiceable, foreign_key: 'invoiceable_id'
  has_one    :notice_to_proceed, class_name: "ProjectDetails::NoticeToProceed", foreign_key: 'project_id'
  belongs_to :main_contractor, class_name: "Contractor", foreign_key: 'main_contractor_id'
  belongs_to :category
  has_many  :employments
  has_many :employees, through: :employments
  has_many :work_details
  has_many :equipment_costs, through: :work_details
  has_many :expenses, class_name: "Plutus::Entry", foreign_key: "commercial_document_id"
  has_many :activities, class_name: "PublicActivity::Activity", foreign_key: "trackable_id"
  has_many :contracts
  has_many :contractors, through: :contracts
  has_many :work_accomplishments, through: :work_details
  has_many :workers, class_name: "Employee"
  has_many :remarks
  has_many :attachment_files
  has_many :issued_inventories
  has_many :equipment_schedules
  has_many :equipments, through: :equipment_schedules

  validates :name, :cost, :implementing_office, :duration, :id_number, :address, presence: true
  validates :id_number, uniqueness: true

  delegate :time_extensions_total, to: :work_details, prefix: true

  def id_number_and_location
    "#{id_number} - #{address}"
  end

  def self.types
    ["JointVenture", "SubcontractWork"]
  end

  def approved_change_orders
    self.work_details.map {|w| w.change_orders.addition.sum(:amount)}
  end

  def mobilization_fund
    self.cost * 0.15
  end

  def total_cost_of_work_details
    self.work_details.sum(:total_cost)
  end

  def previous_billings
    0
  end

  def has_no_change_orders?
    time_extensions.blank? && amount_revisions.blank?
  end

  def total_project_estimate
    work_details.collect{|w| w.total_direct_cost}.sum
  end

  def remaining_uncontracted_amount
    cost - contracts.sum(:amount_subcontracted)
  end

  def total_collection
    self.collections.sum(:amount)
  end

  def remaining_collection
    revised_contract_amount -  total_collection
  end
  def total_expenses
    expenses.joins(:debit_amounts).sum(:amount)
  end


   def total_amount_revision
      self.work_details.collect{|a| a.amount_revisions_total}.sum
  end

  def self.total_amount_revisions
    self.joins(:amount_revisions).sum(:amount)
  end

  def self.total_cost_of_projects_with_revisions
    self.total_amount_revisions + self.sum(:cost)
  end

  def slippage
    if notice_to_proceed.present?
      (actual_accomplishment - target_accomplishment ).round(2)
    else
        0
    end
  end

  def latest_duration
    if time_extensions.present?
      time_extensions.sum(:number_of_days) + duration
    else
      duration
    end
  end

  def actual_accomplishment
    if self.work_accomplishments.present?
      self.work_accomplishments.sum(:quantity)
    else
      0
    end
  end

  def target_accomplishment
    if notice_to_proceed.present?
      ((days_elapsed / duration.to_f) * 100).round(2)
    else
      0
    end
  end

  def no_amount_revisions?
      self.total_amount_revision.zero?
  end

  def revised_contract_amount
    if no_amount_revisions?
      cost
    else
      cost + total_amount_revision
    end
  end

  def final_expiry_date
    if  time_extensions.present?
       revised_expiry_date
    else
      expiry_date
    end
  end

  def start_date
    if notice_to_proceed
      notice_to_proceed.date
    end
  end

  def total_number_of_days_extended
      self.work_details.collect{|a| a.time_extensions_total}.sum
  end

  def days_elapsed
    if self.notice_to_proceed.present?
      ((Time.zone.now.to_i - start_date.to_i)/86400).floor
    else
      0
    end
  end

  def remaining_days
    revised_duration - days_elapsed
  end


  def expiry_date
      if notice_to_proceed.present?
      ((self.notice_to_proceed.date.to_date) + (self.duration))
  end
  end

  def revised_expiry_date
   if notice_to_proceed.present? && time_extensions.present?
      self.notice_to_proceed.date + self.revised_duration.days
    end
  end

  def revised_duration
    self.duration + self.total_number_of_days_extended
  end

  def add_main_contractor_to_contractors
    Contract.create(contractor_id: self.main_contractor.id, project_id: self.id ) if self.new_record?
  end

  def retention_amount
    self.cost * 0.10
  end

  def trade_amount
    self.cost - self.retention_amount
  end

   def add_to_accounts
     Entry.create!(description: self.name, debit_amounts_attributes:[{amount: (self.trade_amount), account: "Accounts Receivable-Trade"},{amount: (self.retention_amount), account: "Accounts Receivable-Retention"}],
                       credit_amounts_attributes:[amount: (self.cost), account: "Cost of Contracts"])
   end

   def update_work_detail_accomplishments_status
    self.work_details.each do |work_detail|
      work_detail.work_accomplishments.unpaid.each do |work_accomplishment|
        work_accomplishment.payment_requested!
      end
    end
  end

  def create_contract
    Contract.create!(contractor_id: self.main_contractor.id, project_id: self.id, amount_subcontracted: nil)
  end

  def update_contract
    Contract.update(contractor_id: self.main_contractor.id, project_id: self.id, amount_subcontracted: nil)
  end

end
