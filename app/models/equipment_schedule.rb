class EquipmentSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :work_detail
end
