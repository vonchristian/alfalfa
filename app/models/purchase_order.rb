class PurchaseOrder < ActiveRecord::Base
  belongs_to :work_detail
end
