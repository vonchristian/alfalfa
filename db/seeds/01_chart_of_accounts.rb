
Plutus::Asset.create(code: 110, :name => "Cash")
Plutus::Asset.create(code: 120, :name => "Accounts Receivable-Trade")
Plutus::Asset.create(code: 121, :name => "Accounts Receivable-Retention")
Plutus::Asset.create(code: 130, :name => "Inventory")
Plutus::Asset.create(code: 140, :name => "Costs and Profits in Excess of Billings")
Plutus::Asset.create(code: 150, :name => "Notes Receivable")
Plutus::Asset.create(code: 160, :name => "Prepaid Expenses")
Plutus::Asset.create(code: 199, :name => "Other Current Assets")
Plutus::Asset.create(code: 210, :name => "Building and Land")
Plutus::Asset.create(code: 220, :name => "Construction Equipment")
Plutus::Asset.create(code: 230, :name => "Trucks and Autos")
Plutus::Asset.create(code: 240, :name => "Office Equipment")
Plutus::Asset.create(code: 250, :name => "Less Accumulated Depreciation")
Plutus::Asset.create(code: 260, :name => "Capital Leases")
Plutus::Asset.create(code: 299, :name => "Other Assets")

Plutus::Liability.create(code: 310, :name => "Accounts Payable-Trade")
Plutus::Liability.create(code: 311, :name => "Accounts Payable-Retention")
Plutus::Liability.create(code: 320, :name => "Billings in Excess of Costs and Profits")
Plutus::Liability.create(code: 330, :name => "Notes Payable")
Plutus::Liability.create(code: 340, :name => "Accrued Payroll")
Plutus::Liability.create(code: 341, :name => "Accrued Payables")
Plutus::Liability.create(code: 342, :name => "Accrued Taxes")
Plutus::Liability.create(code: 343, :name => "Accrued Vacation")
Plutus::Liability.create(code: 344, :name => "Capital Leases Payable")
Plutus::Liability.create(code: 350, :name => "Warranty Reserves")
Plutus::Liability.create(code: 379, :name => "Other Current Liabilities")
Plutus::Liability.create(code: 380, :name => "Long-Term Liabilities")

Plutus::Equity.create(code: 410, :name => "Owner's Capital" )
Plutus::Equity.create(code: 411, :name => "Owner's Drawing", contra: true )
Plutus::Equity.create(code: 420, :name => "Retained Earnings" )
Plutus::Equity.create(code: 430, :name => "Current Period Net Income" )

Plutus::Revenue.create(code: 500, :name => "Revenue")
Plutus::Revenue.create(code: 610, name: "Materials")
Plutus::Revenue.create(code: 620, :name => "Labor" )
Plutus::Revenue.create(code: 630, :name => "Subcontract" )
Plutus::Revenue.create(code: 640, :name => "Equipment" )
Plutus::Revenue.create(code: 650, :name => "Other" )


Plutus::Expense.create(code: 710, :name => "Rent and Lease Payments")
Plutus::Expense.create(code: 720, :name => "Depreciation")
Plutus::Expense.create(code: 730, :name => "Repairs and Maintenance")
Plutus::Expense.create(code: 740, :name => "Fuel and Lubrication")
Plutus::Expense.create(code: 750, :name => "Taxes, Licenses, and Insurance")
Plutus::Expense.create(code: 798, :name => "Equipment Cost Charged to Employee")
Plutus::Expense.create(code: 799, :name => "Equipment Cost Charged to Jobs")

Plutus::Expense.create(code: 805, :name => "Advertising")
Plutus::Expense.create(code: 806, :name => "Promotion")
Plutus::Expense.create(code: 810, :name => "Car and Truck Expenses")
Plutus::Expense.create(code: 811, :name => "Computer and Office Furniture")
Plutus::Expense.create(code: 812, :name => "Repairs and Maintenance")
Plutus::Expense.create(code: 819, :name => "Depreciation")
Plutus::Expense.create(code: 820,  :name => "Employee Wages and Salaries")
Plutus::Expense.create(code: 821, :name => "Employee Benefits")
Plutus::Expense.create(code: 822, :name => "Employee Retirement")
Plutus::Expense.create(code: 823, :name => "Employee Recruiting")
Plutus::Expense.create(code: 824, :name => "Employee Training")
Plutus::Expense.create(code: 825, :name => "Employee Taxes")
Plutus::Expense.create(code: 830, :name => "Insurance")
Plutus::Expense.create(code: 835, :name => "Taxes and Licenses")
Plutus::Expense.create(code: 840, :name => "Office Supplies")
Plutus::Expense.create(code: 841, :name => "Office Purchase")
Plutus::Expense.create(code: 842, :name => "Office Rent")
Plutus::Expense.create(code: 843, :name => "Office Utilities")
Plutus::Expense.create(code: 844, :name => "Postage and Delivery")
Plutus::Expense.create(code: 845, :name => "Janitorial and Cleaning")
Plutus::Expense.create(code: 846, :name => "Telephone")
Plutus::Expense.create(code: 850, :name => "Charitable Contributions")
Plutus::Expense.create(code: 855, :name => "Dues and Memberships")
Plutus::Expense.create(code: 860, :name => "Publications and Subscriptions")
Plutus::Expense.create(code: 865, :name => "Legal and Professional Fees")
Plutus::Expense.create(code: 870, :name => "Meals and Entertainment")
Plutus::Expense.create(code: 875, :name => "Travel")
Plutus::Expense.create(code: 880, :name => "Bank Fees")
Plutus::Expense.create(code: 881, :name => "Interest Expense")
Plutus::Expense.create(code: 885, :name => "Bad Debts")
Plutus::Expense.create(code: 891, :name => "Unallocated Labor")
Plutus::Expense.create(code: 892, :name => "Unallocated Materials")
Plutus::Expense.create(code: 893, :name => "Warranty Expense")
Plutus::Expense.create(code: 898, :name => "Miscellaneous")
Plutus::Expense.create(code: 899, :name => "Overhead Charged to Jobs")












































