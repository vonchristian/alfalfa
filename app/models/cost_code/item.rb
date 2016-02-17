class CostCode::Item < ActiveRecord::Base
  belongs_to :division
  belongs_to :itemable, polymorphic: true
  has_many :item_budgets, as: :item_budgetable
  accepts_nested_attributes_for  :item_budgets
end
