class EquipmentSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :operator, class_name: 'Employee'
end
