class CashAdvance < ActiveRecord::Base
  belongs_to :cash_advanceable, polymorphic: true
end
