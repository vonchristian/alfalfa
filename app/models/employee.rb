class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

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
  has_many :salaries, as: :entriable
  has_many :employments
  has_many :work_details, through: :employments
  has_many :projects, through: :work_details
  has_many :equipment_schedules
  has_many :equipments, through: :equipment_schedules

  def cash_advances
    Transactions::CashAdvance.where(entriable: self)
  end

  def paid!
    self.worked_days.unpaid.set_to_paid!
  end
  def unpaid_worked_days_for(project)
    self.worked_days.unpaid.where(project: project).sum(:number_of_days)
  end

  def unpaid_worked_days
    worked_days.unpaid.total
  end

  def unpaid_worked_days_amount
    unpaid_worked_days * rate
  end

  def unpaid_cash_advances
    Transactions::CashAdvance.unpaid_amount_for(self)
  end

  def total_gross_pay
  unpaid_worked_days_amount - unpaid_cash_advances
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
