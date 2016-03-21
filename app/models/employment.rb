class Employment < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  validates :employee_id, uniqueness: {scope: :project, message: "Already added"}
  delegate :photo, :full_name, :position, :mobile_number, :unpaid_worked_days_for, to: :employee
end
