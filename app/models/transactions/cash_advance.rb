class Transactions::CashAdvance < Accounting::Entry
  def status
    'Paid'
  end
  def self.unpaid_amount_for(employee)
    (Asset.find_by_name( "Advances to Employees").credit_entries.where(entriable: employee).sum(:amount) - Asset.find_by_name( "Advances to Employees").debit_entries.where(entriable: employee).sum(:amount)).abs
  end
end
