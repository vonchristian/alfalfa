class WorkAccomplishment < ActiveRecord::Base
  enum payment_status:[:paid, :pending]
  include PublicActivity::Common
  scope :recent, ->(num) { order('date_accomplished DESC').limit(num) }

  belongs_to :work_detail
  belongs_to :recorder, class_name: "User", foreign_key: 'user_id'
  has_many :images, as: :imageable, dependent: :destroy

  validates :quantity, numericality: { less_than_or_equal_to: :work_detail_quantity, greater_than: 0.01 }
  validates :date_accomplished, :quantity, presence: true

  delegate :quantity, to: :work_detail, prefix: true, allow_nil: true
  delegate :unit, to: :work_detail

  # accepts_attachments_for :images, attachment: :file, append: true

  def self.total
    self.all.sum(:quantity)
  end
end
