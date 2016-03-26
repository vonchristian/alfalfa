class WorkAccomplishment < ActiveRecord::Base
  enum payment_status:[:paid, :unpaid, :payment_requested]
  include PublicActivity::Common
   scope :recent, ->(num) { order('date_accomplished DESC').limit(num) }
  belongs_to :work_detail
  validates :quantity, numericality: { less_than_or_equal_to: :work_detail_quantity }, presence: true
  validates :date_accomplished, presence: true
  delegate :quantity, to: :work_detail, prefix: true
    has_many :images, as: :imageable, dependent: :destroy
    accepts_attachments_for :images, attachment: :file, append: true

  def self.total
    self.all.sum(:quantity)
  end
end
