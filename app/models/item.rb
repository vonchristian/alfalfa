class Item < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true
  validates :date, :unit_cost, :quantity, :total_cost, presence: true
  validates :unit_cost, :total_cost, :quantity, numericality: { greater_than: 0.1}
end
