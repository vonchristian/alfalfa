class CashAdvance < ActiveRecord::Base
  belongs_to :cash_advanceable, polymorphic: true
  validates :amount, numericality: true
  validates :date_disbursed, presence: true
end
