module Transactions
  class SalaryPayment < Accounting::Entry
    def set_cash_advances_to_paid
      self.entriable.set_cash_advances_to_paid
    end
  end
end
