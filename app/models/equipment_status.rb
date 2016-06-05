class EquipmentStatus < ActiveRecord::Base
  enum status:[:active, :inactive]
  belongs_to :equipment
  validates :status, :description, presence: true

  def to_s
    description
  end
end
