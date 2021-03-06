
Asset.create(code: 110, :name => "Cash on Hand")
Asset.create(code: 110.1, :name => "Petty Cash")
Asset.create(code: 112, :name => "Cash in Bank")
Asset.create(code: 120, :name => "Accounts Receivable-Trade")
Asset.create(code: 121, :name => "Accounts Receivable-Retention")
Asset.create(code: 130, :name => "Inventory")
Asset.create(code: 140, :name => "Costs and Profits in Excess of Billings")
Asset.create(code: 150, :name => "Notes Receivable")
Asset.create(code: 160, :name => "Prepaid Expenses")
Asset.create(code: 199, :name => "Other Current Assets")
Asset.create(code: 210, :name => "Building and Land")
Asset.create(code: 210.1, :name => "Buildings")
Asset.create(code: 210.2, :name => "Land")
Asset.create(code: 220, :name => "Construction Equipment")
Asset.create(code: 230, :name => "Trucks and Autos")
Asset.create(code: 240, :name => "Office Equipment")
Asset.create(code: 250, :name => "Less Accumulated Depreciation")
Asset.create(code: 260, :name => "Capital Leases")
Asset.create(code: 299, :name => "Other Assets")
Asset.create(code: 170, :name => "Advances to Employees")

Liability.create(code: 310, :name => "Accounts Payable-Trade")
Liability.create(code: 311, :name => "Accounts Payable-Retention")
Liability.create(code: 320, :name => "Billings in Excess of Costs and Profits")
Liability.create(code: 330, :name => "Notes Payable")
Liability.create(code: 340, :name => "Accrued Payroll")
Liability.create(code: 341, :name => "Accrued Payables")
Liability.create(code: 342, :name => "Accrued Taxes")
Liability.create(code: 343, :name => "Accrued Vacation")
Liability.create(code: 344, :name => "Capital Leases Payable")
Liability.create(code: 350, :name => "Warranty Reserves")
Liability.create(code: 379, :name => "Other Current Liabilities")
Liability.create(code: 380, :name => "Long-Term Liabilities")

Equity.create(code: 410, :name => "Owner's Capital" )
Equity.create(code: 411, :name => "Owner's Drawing", contra: true )
Equity.create(code: 412, :name => "Fund Transfers", contra: true )
Equity.create(code: 420, :name => "Retained Earnings" )
Equity.create(code: 430, :name => "Current Period Net Income" )

Revenue.create(code: 500, :name => "Revenue")
#Construction Costs
Expense.create(code: 610, :name => "Materials")
Expense.create(code: 620, :name => "Labor")
Expense.create(code: 630, :name => "Subcontract")
Expense.create(code: 640, :name => "Equipment")
Expense.create(code: 650, :name => "Other Costs")


#Equipment Costs
Expense.create(code: 710, :name => "Rent and Lease Payments")
Expense.create(code: 720, :name => "Depreciation")
Expense.create(code: 730, :name => "Repairs and Maintenance")
Expense.create(code: 730.1, name: "Repairs")
Expense.create(code: 730.2, name: "Maintenance")
Expense.create(code: 730.3, name: "Tires")


Expense.create(code: 740, :name => "Fuel and Lubrication")
Expense.create(code: 750, :name => "Taxes, Licenses, and Insurance")
Expense.create(code: 798, :name => "Equipment Cost Charged to Employee", contra: true )
Expense.create(code: 799, :name => "Equipment Cost Charged to Jobs", contra: true)

Expense.create(code: 805, :name => "Advertising")
Expense.create(code: 806, :name => "Promotion")
Expense.create(code: 810, :name => "Car and Truck Expenses")
Expense.create(code: 811, :name => "Computer and Office Furniture")
Expense.create(code: 820,  :name => "Employee Wages and Salaries")
Expense.create(code: 821, :name => "Employee Benefits")
Expense.create(code: 822, :name => "Employee Retirement")
Expense.create(code: 823, :name => "Employee Recruiting")
Expense.create(code: 824, :name => "Employee Training")
Expense.create(code: 825, :name => "Employee Taxes")
Expense.create(code: 830, :name => "Insurance")
Expense.create(code: 835, :name => "Taxes and Licenses")
Expense.create(code: 840, :name => "Office Supplies")
Expense.create(code: 841, :name => "Office Purchase")
Expense.create(code: 842, :name => "Office Rent")
Expense.create(code: 843, :name => "Office Utilities")
Expense.create(code: 844, :name => "Postage and Delivery")
Expense.create(code: 845, :name => "Janitorial and Cleaning")
Expense.create(code: 846, :name => "Telephone")
Expense.create(code: 850, :name => "Charitable Contributions")
Expense.create(code: 855, :name => "Dues and Memberships")
Expense.create(code: 860, :name => "Publications and Subscriptions")
Expense.create(code: 865, :name => "Legal and Professional Fees")
Expense.create(code: 870, :name => "Meals and Entertainment")
Expense.create(code: 875, :name => "Travel")
Expense.create(code: 880, :name => "Bank Fees")
Expense.create(code: 881, :name => "Interest Expense")
Expense.create(code: 885, :name => "Bad Debts")
Expense.create(code: 891, :name => "Unallocated Labor")
Expense.create(code: 892, :name => "Unallocated Materials")
Expense.create(code: 893, :name => "Warranty Expense")
Expense.create(code: 898, :name => "Miscellaneous")
Expense.create(code: 899, :name => "Overhead Charged to Jobs")
Revenue.create(code: 910, :name => "Other Income")
Expense.create(code: 920, :name => "Other Expense")
Expense.create(code: 950, :name => "Income Tax")
