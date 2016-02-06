class Bid < ActiveRecord::Base
  belongs_to :project
  has_many :bidders, class_name: "Contractor"
  has_many :requirements
  has_many :documents, through: :requirements
end
