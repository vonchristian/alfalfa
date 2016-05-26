class EquipmentSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :project
  belongs_to :operator, class_name: 'Employee', foreign_key: "employee_id"
  delegate :full_name, to: :employee

  validates_presence_of :start_date, :end_date, :project_id, :employee_id, :purpose
end
