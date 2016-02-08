class Accomplishment < ActiveRecord::Base
  validates :percent, numericality: {less_than: 100.0, message: "Exceeded allowed value."}
  belongs_to :project
end
