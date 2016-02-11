class Accomplishment < ActiveRecord::Base
   include PublicActivity::Common
  validates :percent, numericality: {less_than: 100.0, message: "Exceeded allowed value."}
  belongs_to :project

  def self.total
    self.all.sum(:percent)
  end
end
