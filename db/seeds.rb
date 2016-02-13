# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Contractor.create(first_name: "Letty", middle_name: "Bulayo", last_name: "Ngipol", company: "Alfalfa Construction Inc.", position: "President", main_contractor: true)
Contractor.create(first_name: "Letty", middle_name: "Bulayo", last_name: "Ngipol", company: "Bugani Construction Inc.", position: "President", main_contractor: true)
Contractor.create(first_name: "Donald", middle_name: "", last_name: "Mongolnon", company: "D & A Enterprises", position: "President", main_contractor: true)


Plutus::Asset.create(:name => "Cash")
Plutus::Asset.create(:name => "Receivables")
Plutus::Asset.create(:name => "Supplies")
Plutus::Asset.create(:name => "Longterm Investment in Stocks")
Plutus::Asset.create(:name => "Properties and Equipment")

Plutus::Liability.create(:name => "Trade Payable")
Plutus::Liability.create(:name => "Loan Payable")


Plutus::Equity.create(name: "Capital")
Plutus::Equity.create(name: "Net Surplus")
Plutus::Equity.create(name: "Additional Capital")

Plutus::Expense.create(name: "Salaries and Wages")
Plutus::Expense.create(name: "PHILHEALTH, SSS")
Plutus::Expense.create(name: "Gas and Oil")
Plutus::Expense.create(name: "Communications")
Plutus::Expense.create(name: "Utilities Expense")
Plutus::Expense.create(name: "Entertainment Expense")
Plutus::Expense.create(name: "Office Supplies")
Plutus::Expense.create(name: "Depreciation")
Plutus::Expense.create(name: "Taxes and Licenses")
Plutus::Expense.create(name: "Repairs and Maintenance")
Plutus::Expense.create(name: "Miscellaneous")
Plutus::Expense.create(name: "Overhead")


User.create!(first_name: 'Juan', last_name: 'Cruz', role: 0, email: 'vc.halip@gmail.com', password: '1111111111', password_confirmation: '1111111111')
