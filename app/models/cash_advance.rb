class CashAdvance < ActiveRecord::Base
  belongs_to :cash_advanceable, polymorphic: true

  enum status:[:paid, :unpaid]

  validates :amount, numericality: true
  validates :date_disbursed, presence: true

  def self.unpaid_amounts
    self.unpaid.sum(:amount)
  end

  def self.set_to_paid!
    self.all.unpaid.each do |a|
      a.paid!
      a.save
    end
  end

end
