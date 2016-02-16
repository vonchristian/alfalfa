class BillableMaterial < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :inventory
  belongs_to :project
end
