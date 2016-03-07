class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  attachment :photo

  enum position:[:laborer, :skilled_laborer, :project_foreman, :operator, :welder, :project_engineer, :bookkeeper, :liason_officer]
  validates :first_name, :last_name, :email, :mobile_number, :position, presence: true
  # validates :full_name, uniqueness: true
  has_many :educational_attainments, class_name: "EmployeeDetails::EducationalAttainment"
  has_many :worked_days
  has_many :payments, as: :paymentable
  has_many :cash_advances, as: :cash_advanceable
  has_many :employments
  has_many :projects, through: :employments

  def unpaid_worked_days_for(project)
    self.worked_days.where(project_id: project, status: 'unpaid').sum(:number_of_days)
  end

  def set_unpaid_worked_days_to_paid!
    self.worked_days.unpaid.each {|a| a.paid!}
  end

  def unpaid_worked_days
    self.worked_days.unpaid.sum(:number_of_days)
  end

  def earned_income
    self.unpaid_worked_days_amount - self.unpaid_cash_advances
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
