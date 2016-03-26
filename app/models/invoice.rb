class Invoice < ActiveRecord::Base
  belongs_to :invoiceable, polymorphic:true
  has_many :payments
end
