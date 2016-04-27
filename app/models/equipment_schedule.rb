class EquipmentSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :project
  belongs_to :operator, class_name: 'Employee', foreign_key: "employee_id"
  delegate :full_name, to: :employee
end
