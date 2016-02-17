class ItemBudget < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
  validates :item_code, :item_description, presence: true, uniqueness: true
  validates :unit_price, :quantity, presence: true, numericality: true
end
