class CashAdvance < ActiveRecord::Base
  validates :amount, numericality: true
  validates :date_disbursed, presence: true
end
