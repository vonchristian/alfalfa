class Accomplishment < ActiveRecord::Base
   include PublicActivity::Common
  validates :percent, numericality: {less_than: 100.0, message: "Exceeded allowed value."}
  belongs_to :project
   has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true

  def self.total
    self.all.sum(:percent)
  end
end
