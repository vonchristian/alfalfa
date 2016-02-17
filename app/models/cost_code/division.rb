class CostCode::Division < ActiveRecord::Base
  has_many :items, class_name: "CostCode::Item"
end

