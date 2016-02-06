class Contract < ActiveRecord::Base
  belongs_to :project
  belongs_to :contractor
  #validates :contractor, uniqueness: {message: "is already a contractor for this project" }
end
