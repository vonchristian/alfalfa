class Maintenance < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :employee
  belongs_to :work_detail

  validates :equipment_id, presence: true
end
