class WorkAccomplishment < ActiveRecord::Base
  include PublicActivity::Common
 scope :recent, ->(num) { order('date_accomplished DESC').limit(num) }
  belongs_to :work_detail
  validates :quantity, numericality: { less_than_or_equal_to: :work_detail_quantity }
  delegate :quantity, to: :work_detail, prefix: true
    has_many :images, as: :imageable, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true

end
