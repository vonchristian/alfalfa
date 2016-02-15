class Contract < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  belongs_to :contractor
  validates :contractor, presence: true
  validates :amount, numericality: true
end
