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

  validates :profile_photo, :first_name, :last_name, :email, :mobile_number, :position, :rate, presence: true

  has_many :educational_attainments, class_name: "EmployeeDetails::EducationalAttainment"
  has_many :worked_days
  has_many :salaries, as: :entriable, class_name: "Transactions::SalaryPayment"
  has_many :employments
  has_many :work_details, through: :employments
  has_many :projects, through: :work_details
  has_many :equipment_schedules
  has_many :equipments, through: :equipment_schedules

  has_many :overtimes, class_name: "Accounting::Employees::Overtime"
  def self.total_gross_pay
    all.map{ |a| a.total_gross_pay }.sum
  end
  def self.total_earned_income
    all.map{ |a| a.earned_income }.sum
  end
  def self.total_cash_advances
    all.map{ |a| a.unpaid_cash_advances }.sum
  end
  def cash_advances
    Transactions::CashAdvance.where(entriable: self)
  end

  def paid!
    self.worked_days.unpaid.set_to_paid!
    self.overtimes.set_to_paid!
  end

  def unpaid_worked_days
    worked_days.unpaid.total
  end

  def unpaid_overtimes
    overtimes.unpaid.total
  end

  def unpaid_overtimes_amount
    overtimes.unpaid.total * overtime_rate
  end

  def earned_income
    unpaid_worked_days_amount + unpaid_overtimes_amount
  end

  def unpaid_overtimes_amount
    unpaid_overtimes * overtime_rate
  end

  def overtime_rate
    rate / 8.0
  end

  def unpaid_worked_days_amount
    unpaid_worked_days * rate
  end

  def unpaid_cash_advances
    Transactions::CashAdvance.unpaid_amount_for(self)
  end

  def total_gross_pay
  earned_income - unpaid_cash_advances - contributions
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

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def name
  	"#{first_name.titleize} #{last_name.titleize}"
  end
end
