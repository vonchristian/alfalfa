class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  attachment :photo

  enum position:[:laborer, :skilled_laborer, :project_foreman, :operator, :welder, :project_engineer, :bookkeeper, :liason_officer, :supply_officer, :accounting_officer, :monitoring_officer, :mechanical_engineer]
  validates :first_name, :last_name, :email, :mobile_number, :position, presence: true
  # validates :full_name, uniqueness: true
  has_many :educational_attainments, class_name: "EmployeeDetails::EducationalAttainment"
  has_many :worked_days
  has_many :payments, as: :paymentable
  
  has_many :employments
  has_many :projects, through: :employments
  
  def cash_advances
    Account.find_by_name("Cash Advances").debit_entries.where(recipient: self)
  end
  def paid!
    self.worked_days.unpaid.set_to_paid!
  end
  def unpaid_worked_days_for(project)
    self.worked_days.where(project_id: project, status: 'unpaid').sum(:number_of_days)
  end

  def unpaid_worked_days
    self.worked_days.unpaid.total
  end

  def unpaid_worked_days_amount
    unpaid_worked_days * rate
  end

  def unpaid_cash_advances
    self.cash_advances.sum(:amount)
  end

  def gross_pay
    self.unpaid_worked_days_amount - self.unpaid_cash_advances
  end



#find the number of days that an employee worked for a project but are not paid
  def unpaid_worked_days_amount_for(project)
    self.unpaid_worked_days_for(project) * self.rate
  end

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def name
  	full_name
  end
end
