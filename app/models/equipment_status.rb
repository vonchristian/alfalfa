class EquipmentStatus < ActiveRecord::Base

  enum status:[:active, :inactive]
  belongs_to :equipment
  validates :status, presence: true
end
