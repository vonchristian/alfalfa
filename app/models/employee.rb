class Employee < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => [:first_name, :last_name]

  has_attached_file :profile_photo,
                    styles: { large: "120x120>",
                    medium: "70x70>", thumb: "40x40>",
                    small: "30x30>", x_small: "20x20>" },
                    default_url: ":style/profile_default.jpg",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment_content_type :profile_photo, content_type: /\Aimage\/.*\Z/
  enum position:[:laborer,
                 :skilled_laborer,
                 :project_foreman,
                 :operator,
                 :welder,
                 :project_engineer,
                 :bookkeeper,
                 :liason_officer,
                 :supply_officer,
                 :accounting_officer,
                 :monitoring_officer,
                 :mechanical_engineer]

  validates :first_name, :last_name, presence: true

  has_many :educational_attainments, class_name: "EmployeeDetails::EducationalAttainment"
  has_many :worked_days
  has_many :salaries, as: :entriable, class_name: "Transactions::SalaryPayment"
  has_many :employments
  has_many :work_details, through: :employments
  has_many :projects, through: :work_details
  has_many :equipment_schedules
  has_many :equipments, through: :equipment_schedules

  has_many :overtimes, class_name: "Accounting::Employees::Overtime"
  enum employee_type:[:regular, :irregular]
  def self.with_cash_advances
    all.map{|a| a.unpaid_cash_advances > 0}
  end
  def self.other_deductions
    all.map{ |a| a.total_other_deductions }.sum
  end

  def self.total_gross_pay
    all.map{ |a| a.total_gross_pay }.sum
  end

  def self.total_earned_income
    all.map{ |a| a.earned_income }.sum
  end

  def self.total_cash_advances
    all.map{ |a| a.unpaid_cash_advances }.sum
  end

  def self.total_advanced_ppes
    all.map{ |a| a.unpaid_advanced_ppes }.sum
  end

  def cash_advances
    Account.find_by_name("Advances to Employees").debit_entries.where(entriable: self)
  end

  def advanced_ppes
    Account.find_by_name("Advances to Employees (PPE)").debit_entries.where(entriable: self)
  end

  def paid!
    self.worked_days.unpaid.set_to_paid!
    self.overtimes.set_to_paid!
  end

  def unpaid_worked_days
    if worked_days.any?
      worked_days.unpaid.total
    else
      0
    end
  end

  def unpaid_overtimes
    if overtimes.any?
      overtimes.unpaid.total
    else
      0
    end
  end

  def unpaid_overtimes_amount
    if overtimes.any?
      overtimes.unpaid.total * overtime_rate
    else
      0
    end
  end

  def earned_income
    if self.worked_days.present?
    unpaid_worked_days_amount + unpaid_overtimes_amount
  else
    0
  end
  end

  def unpaid_overtimes_amount
    if self.overtimes.present?
    unpaid_overtimes * overtime_rate
  else
    0
  end
  end

  def overtime_rate
    if rate.present?
    rate / 8.0
  else
    0
  end
  end

  def unpaid_worked_days_amount
    if worked_days.any? && rate.present?
    unpaid_worked_days * rate
  else
    0
  end
  end

  def unpaid_cash_advances
    if cash_advances.any?
      cash_advances.all.map{|a| a.debit_amounts.sum(:amount)}.sum
    else
      0
    end
  end
  def unpaid_advanced_ppes
    if advanced_ppes.any?
      advanced_ppes.all.map{|a| a.debit_amounts.sum(:amount)}.sum
    else
      0
    end
  end

  def total_gross_pay
    if self.worked_days.present?
      earned_income - total_deductions
    else
      0
    end
  end

  def total_deductions
    unpaid_cash_advances + contributions + unpaid_advanced_ppes
  end

  def contributions
    philhealth + sss_contribution
  end

  def philhealth
    100.00
  end
  def sss_contribution
    182.00
  end

  def gross_pay(project)
    (self.unpaid_worked_days_for(project) * self.rate) - self.unpaid_cash_advances
  end



#find the number of days that an employee worked for a project but are not paid
  def unpaid_worked_days_amount_for(project)
    self.unpaid_worked_days_for(project) * self.rate
  end
  def last_name_first_name
    "#{last_name.titleize}, #{first_name.titleize}"
  end
  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def name
  	"#{first_name.titleize} #{last_name.titleize}"
  end
end
