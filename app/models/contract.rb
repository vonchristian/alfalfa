class Contract < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  belongs_to :contractor
  #validates :contractor, uniqueness: {message: "is already a contractor for this project" }
end
