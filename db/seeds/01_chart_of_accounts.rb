
Plutus::Asset.create(:name => "Petty Cash")
Plutus::Asset.create(:name => "Cash in Bank")

Plutus::Asset.create(:name => "Accounts Receivable-Trade")
Plutus::Asset.create(:name => "Accounts Receivable-Retention")
Plutus::Asset.create(:name => "Inventory")
Plutus::Asset.create(:name => "Prepaid Insurance")
Plutus::Asset.create(:name => "Prepaid Rent")
Plutus::Asset.create(:name => "Land")
Plutus::Asset.create(:name => "Building")
Plutus::Asset.create(:name => "Construction Equipment")
Plutus::Asset.create(:name => "Trucks and Autos")
Plutus::Asset.create(:name => "Office Equipment")
Plutus::Asset.create(:name => "Accumulated Depreciation-Office Equipment", contra: true)
Plutus::Asset.create(:name => "Accumulated Depreciation-Construction Equipment", contra: true)
Plutus::Asset.create(:name => "Accumulated Depreciation-Building", contra: true)
Plutus::Asset.create(:name => "Accumulated Depreciation-Trucks and Autos", contra: true)


Plutus::Liability.create(:name => "Accounts Payable-Trade")
Plutus::Liability.create(:name => "Accounts Payable-Retension")
Plutus::Liability.create(:name => "Billings in Excess of Costs and Profits")
Plutus::Liability.create(:name => "Loans Payable")
Plutus::Liability.create(:name => "Accrued Payroll")
Plutus::Liability.create(:name => "Accrued Payables")
Plutus::Liability.create(:name => "Accrued Taxes")
# Plutus::Liability.create(:name => "Accrued Insurance")
# Plutus::Liability.create(:name => "Accrued Vacation")
# Plutus::Liability.create(:name => "Capital Leases Payable")
# Plutus::Liability.create(:name => "Warranty Reserves")
# Plutus::Liability.create(:name => "Other Current Liabilities")
# Plutus::Liability.create(:name => "Long-Term Liabilities")

Plutus::Equity.create(:name => "Owner's Capital" )
Plutus::Equity.create(:name => "Owner's Drawing", contra: true )
Plutus::Equity.create(:name => "Retained Earnings" )

Plutus::Revenue.create(:name => "Cost of Projects")
Plutus::Revenue.create(name: "Sales Revenue")

Plutus::Expense.create(:name => "Direct Labor")
Plutus::Expense.create(:name => "Direct Material")
Plutus::Expense.create(:name => "Direct Labor")

Plutus::Expense.create(name: "Royalty Expense")
Plutus::Expense.create(:name => "Rent")
Plutus::Expense.create(:name => "Lease")

Plutus::Expense.create(:name => "Depreciation")
Plutus::Expense.create(:name => "Repairs and Maintenance")
Plutus::Expense.create(:name => "Fuel and Lubrication")
Plutus::Expense.create(:name => "Taxes, Licenses, and Insurance")
Plutus::Expense.create(:name => "Equipment Cost Charged to Employee")
Plutus::Expense.create(:name => "Equipment Cost Charged to Jobs")

Plutus::Expense.create(:name => "Advertising")
Plutus::Expense.create(:name => "Promotion")
Plutus::Expense.create(:name => "Computer and Office Furniture")
Plutus::Expense.create(:name => "Repairs and Maintenance")
Plutus::Expense.create(:name => "Depreciation")
Plutus::Expense.create(:name => "Salaries and Wages-Regular")
Plutus::Expense.create(:name => "Salaries and Wages-Temporary Worker")

Plutus::Expense.create(:name => "Employee Benefits")
Plutus::Expense.create(:name => "Employee Retirement")
Plutus::Expense.create(:name => "Employee Recruiting")
Plutus::Expense.create(:name => "Employee Training")
Plutus::Expense.create(:name => "Employee Taxes")
Plutus::Expense.create(:name => "Insurance")
Plutus::Expense.create(:name => "Taxes and Licenses")
Plutus::Expense.create(:name => "Office Supplies")
Plutus::Expense.create(:name => "Office Purchase")
Plutus::Expense.create(:name => "Office Rent")
Plutus::Expense.create(:name => "Office Utilities")
Plutus::Expense.create(:name => "Postage and Delivery")
Plutus::Expense.create(:name => "Janitorial and Cleaning")
Plutus::Expense.create(:name => "Telephone")
Plutus::Expense.create(:name => "Charitable Contributions")
Plutus::Expense.create(:name => "Dues and Memberships")
Plutus::Expense.create(:name => "Publications and Subscriptions")
Plutus::Expense.create(:name => "Legal and Professional Fees")
Plutus::Expense.create(:name => "Meals and Entertainment")
Plutus::Expense.create(:name => "Travel")
Plutus::Expense.create(:name => "Bank Fees")
Plutus::Expense.create(:name => "Interest Expense")
Plutus::Expense.create(:name => "Bad Debts")
Plutus::Expense.create(:name => "Unallocated Labor")
Plutus::Expense.create(:name => "Unallocated Materials")
Plutus::Expense.create(:name => "Warranty Expense")
Plutus::Expense.create(:name => "Miscellaneous")
Plutus::Expense.create(:name => "Overhead Charged to Jobs")


Plutus::Expense.create(:name => "Other Expense")
Plutus::Expense.create(:name => "Income Tax")










































