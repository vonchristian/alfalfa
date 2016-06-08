class Item < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true

  enum payment_status:[:unpaid, :paid]
  validates :date, :unit_cost, :quantity, :total_cost, presence: true
  validates :unit_cost, :total_cost, :quantity, numericality: { greater_than: 0.1}
  def self.set_to_paid!
    self.all.unpaid.each do |a|
      a.paid!
      a.save
    end
  end

end
