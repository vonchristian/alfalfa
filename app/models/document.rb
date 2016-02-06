class Document < ActiveRecord::Base
  has_many :requirements
  has_many :bids, through: :requirements
end
