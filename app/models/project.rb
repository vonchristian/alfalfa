class Project < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  pg_search_scope :search_by_name, :against => [:name, :id_number, :address]
  multisearchable :against => [:name, :id_number],
   :order_within_rank => "projects.created_at DESC"
   pg_search_scope :search_by_name, :against => :name
  scope :joint_ventures, -> { where(type: 'JointVenture') }

  has_many :payments, as: :entriable, class_name: "Accounting::Entry"
  has_one    :notice_to_proceed, class_name: "ProjectDetails::NoticeToProceed", foreign_key: 'project_id', dependent: :destroy
  belongs_to :main_contractor, class_name: "Contractor", foreign_key: 'main_contractor_id'
  belongs_to :category
  has_many  :employments
  has_many :employees, through: :employments
  has_many :work_details, -> { order 'id asc' }
  has_many :amount_revisions, through: :work_details
  has_many :time_extensions, class_name: "ChangeOrders::TimeExtension"
  has_many :accomplishment_images, through: :work_details
  has_many :contracts
  has_many :contractors, through: :contracts
  has_many :work_accomplishments, through: :work_details
  has_many :accomplishment_images, through: :work_accomplishments
  has_many :attachment_files
  has_many :equipment_schedules
  has_many :equipments, through: :equipment_schedules
  has_many :file_attachments
  has_many :bid_expenses

  has_many :costs
  has_many :labor_costs, class_name: "DirectCosts::Labor"
  has_many :equipment_costs, class_name: "DirectCosts::Equipment"
  has_many :material_costs, class_name: "DirectCosts::Material"
  has_many :sub_contract_costs, class_name: "DirectCosts::SubContract"
  has_many :other_costs, class_name: "DirectCosts::OtherCost"

  has_many :orders, as: :customer,  class_name: "Supplies::Order"
  has_many :line_items, through: :orders, class_name: "Supplies::LineItem"
  has_many :purchase_orders, class_name: "Monitoring::PurchaseOrder"

  validates :name, :cost, :implementing_office, :duration, :id_number, :address, presence: true
  validates :id_number, uniqueness: true

  def effectivity_date
    if notice_to_proceed.present?
      notice_to_proceed.date + 7.days
    end
  end

  def total_direct_costs
    costs.total + direct_material_costs + bid_expenses.sum(:amount) if bid_expenses.present?
  end

  def id_number_and_location
    "#{id_number} - #{address}"
  end

  def select2_options
    id_number_and_location
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

  def has_no_time_extensions?
    time_extensions.blank?
  end

  def total_project_estimate
    work_details.collect{|w| w.total_direct_cost}.sum
  end

  def remaining_uncontracted_amount
    cost - contracts.sum(:amount_subcontracted)
  end

  def total_payments
    self.payments.map{|a| a.credit_amounts.sum(:amount)}.sum
  end

  def remaining_payments
    revised_contract_amount -  total_payments
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
      (actual_accomplishment - target_accomplishment )
    else
        0
    end
  end

  def start_date
    if notice_to_proceed
      notice_to_proceed.date
    else
      "No NTP"
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
      (self.work_accomplishments.sum(:quantity) / self.work_details.sum(:quantity)) * 100
    else
      0
    end
  end

  def target_accomplishment
    if notice_to_proceed.present?
      ((days_elapsed / duration.to_f) * 100)
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

  def total_number_of_days_extended
      self.time_extensions.total
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


  def revised_expiry_date
   if notice_to_proceed.present? && time_extensions.present?
      self.notice_to_proceed.date + self.revised_duration.days + 7.days
    end
  end

  def revised_duration
    self.duration + self.total_number_of_days_extended
  end


  def retention_amount
    self.cost * 0.10
  end

  def trade_amount
    self.cost - self.retention_amount
  end

  def add_to_accounts
    Entry.create!(description: self.name, debit_amounts_attributes:[{amount: (self.trade_amount), account: "Accounts Receivable-Trade"},{amount: (self.retention_amount), account: "Accounts Receivable-Retention"}],
                       credit_amounts_attributes:[amount: (self.cost), account: "Revenue"])
  end

  def update_work_detail_accomplishments_status
    self.work_details.each do |work_detail|
      work_detail.work_accomplishments.unpaid.each do |work_accomplishment|
        work_accomplishment.payment_requested!
      end
    end
  end

  def direct_material_costs
    self.line_items.total_price + self.purchase_orders.total_price
  end
end
