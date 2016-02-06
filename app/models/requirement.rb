class Requirement < ActiveRecord::Base
  belongs_to :bid
  belongs_to :document
end
